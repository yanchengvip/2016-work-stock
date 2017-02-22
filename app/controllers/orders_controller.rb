class OrdersController < ApplicationController
  #skip_before_filter :authenticate_user!, only: [:pay_by_code]
  skip_before_filter :set_area, only: [:pay_by_code]
  before_filter :set_order, only: [:show, :destroy, :payment, :pay, :paysuccess, :stocks, :buy_again, :logistics, :cancel]
  before_filter :set_order_group, only: [:info, :confirm, :submit_success]
  before_filter :authority_verify!, only: [:show, :payment, :confirm, :paysuccess, :pay, :destroy, :cancel]
  skip_before_filter :verify_authenticity_token, only: [:order_score]

  def info_order
  end

  def create
    # order_group, message = current_user.cart_to_orders(params[:list], {depot_ids: session[:depot_ids], city_id: cookies[:city_id], from_app: params[:inApp], user_agent: request.env["HTTP_USER_AGENT"]})
    order_group, message = current_user.cart_to_orders(params[:list], {depot_ids: session[:depot_ids], city_id: session[:city_id], from_app: params[:inApp], user_agent: request.env["HTTP_USER_AGENT"]})
    if order_group
      respond_to do |format|
        format.html { redirect_to order_info_path(id: order_group.ID) }
        format.json { render json: {status: 'ok', order_group_id: order_group.ID} }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back }
        format.json { render json: {status: 'error', message: message || '操作失败'} }
      end
    end
  end

  def info
    @orders = @order_group.orders
    @address = UserAddress.find_by(ID: params[:address_id]) || current_user.default_address
  end

  def stocks
    address = UserAddress.find_by(ID: params[:address_id])
    @order_products = @order.order_products
    @stocks = DepotProductStock.stocks_for(@order_products.map(&:ProductID), address)
  end

  def confirm
    if @order_group.Status.present?
      render json: {status: 'error', message: '订单不可重复提交'}
      return
    end
    status, message = true, nil
    opt = {company_id: cookies[:company_id], address_id: params[:AddressID], user_ip: request.remote_ip, user_agent: request.env["HTTP_USER_AGENT"]}
    status, message = current_user.confirm_orders(@order_group, order_params, params[:orders], opt) if status
    if status
      if (address = UserAddress.find_by(ID: params[:AddressID])) and address.UserID == current_user.ID and !address.IsDefault
        current_user.set_default_address(address)
      end
      render json: {status: 'ok'}
    else
      render json: {status: 'error', message: message || '操作失败'}
    end
  end

  def submit_success
  end

  def show
    if @order.OrderStatus.blank?
      redirect_to order_info_path(id: @order.ID)
      return
    end
    @is_submit = true
    @order_products = @order.order_products.includes(:product => [:product_info])

    @status, @message = true, nil
    if @order.OrderStatus == 0
      @status, @message = false, '订单已失效' if @order.SubmitDate < Time.now - 12.hours
      @status, @message = @order.check_price_and_stock if @status
    end
  end

  def payment
    if @order.OrderStatus != 0
      redirect_to order_path(@order)
      return
    end
    status, message = true, nil
    status, message = false, '订单已失效' if @order.SubmitDate < Time.now - 12.hours
    status, message = @order.check_price_and_stock if status
    redirect_to order_path(@order), flash: {error: message} if !status
  end

  def pay
    if @order.OrderStatus != 0
      redirect_to order_path(@order)
      return
    end
    status, message, coupon = true, nil, nil
    status, message = false, '订单已失效' if @order.SubmitDate < Time.now - 12.hours
    status, message = @order.check_price_and_stock if status
    status, message = false, '积分不足' if status and params[:PointPrice].to_i > current_user.Integral.to_i
    if status and params[:CouponCode].present?
      coupon = current_user.usable_coupons(@order.CostItem).find_by(ID: params[:CouponCode])
      status, message = false, '优惠券无效' if !coupon
      status, message = false, '订单金额未满足优惠券使用条件' if @order.CostItem < coupon.UseMoney.to_f
    end
    status, message = current_user.confirm_order(@order, coupon, {mode: params[:mode], user_ip: request.remote_ip, user_agent: request.env["HTTP_USER_AGENT"]}) if status
    if status
      redirect_to paysuccess_order_path(@order)
    else
      redirect_to payment_order_path(@order), flash: {error: message || '操作失败'}
    end
  end

  def paysuccess

  end

  def logistics
    @logistics_logs = @order.logistics_logs
  end

  def reviews
  end

  def destroy
    if @order != nil && @order.OrderStatus == 0 && @order.destroy
      respond_to do |format|
        format.html { redirect_to :back }
        format.json { render json: {status: 'ok'} }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back }
        format.json { render json: {status: 'error', message: '操作失败'} }
      end
    end
  end

  def buy_again
    #状态为已完成的订单可以再次购买
    if @order.OrderStatus == 4 or @order.OrderStatus == 5 or @order.OrderStatus == 8
      current_user.buy_again @order
      respond_to do |format|
        format.html { redirect_to carts_path }
        format.json { render json: {status: 'ok'} }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back }
        format.json { render json: {status: 'error', message: '已完成的订单才可再次购买' } }
      end
    end
  end

  def buy_speed
    order = current_user.orders.where("OrderStatus = 4 or OrderStatus = 5 or OrderStatus = 8").first
    if order
      current_user.buy_again order
      redirect_to carts_path
    else
      redirect_to list_products_path
    end
  end

  # 订单评价
  def order_score
    # {order_code: '', sales_score: '', sales_evaluate: '', driver_score: '', sale_score_tags: "有责任心,服务周到", driver_score_tags: "有责任心,服务周到"}
    sale_score_tags = params[:sale_score_tags].split(",")
    driver_score_tags = params[:driver_score_tags].split(",")
    message = {status: 'error', content: '评价保存失败'}
    @order = Order.where(OrderCode: params[:order_code]).first
    completed_time = @order.CompletedTime ||= Time.now
    is_score = OrderScore.where(OrderID: @order.ID).empty?
    render json: {status: 'error',content: '订单已评价,不能多次评价！'} and return if !is_score

    if (completed_time + 30.days) <= Time.now
      #评价30天能有效
      render json: {status: 'error',content: '订单评价已过时,30天内有效！'} and return
    end
    ActiveRecord::Base.transaction do
      @order_score = OrderScore.create(OrderID: @order.ID, SalesScore: params[:sales_score].to_i, SalesEvaluate: params[:sales_evaluate], DriverScore: params[:driver_score], DriverEvaluate: params[:sales_evaluate], CreateBy: current_user.Name)
      # 业务员tag type = 0 为业务员评价
      sale_score_tags.each do |sale_tag|
        @order_score.order_score_tags.create(Type: 0, Tag: sale_tag, CreateBy: current_user.Name)
      end
      # 司机tag type = 1 为司机评价
      driver_score_tags.each do |driver_tag|
        @order_score.order_score_tags.create(Type: 1, Tag: driver_tag, CreateBy: current_user.Name)
      end
      message = {status: 'ok', content: '评价保存成功'} if @order_score
    end
    render json: message

  end

  def pay_by_code
    @order = Order.find_by(OrderCode: params[:id])
    @order_products = @order.order_products.includes(:product => [:product_info])
  end

  def poundage
    if params[:paymoney].present?
      poundage, message = Utils::Client.poundage params[:paymoney]
      if poundage
        render json: {status: 'ok', data: {poundage: poundage}}
      else
        render json: {status: 'error', message: message}
      end
    else
      render json: {status: 'error', message: '信息不全'}
    end
  end

  def cancel
    status, message = current_user.cancel_order @order, params[:reason], {user_ip: request.remote_ip, user_agent: request.env["HTTP_USER_AGENT"]}
    if status
      render json: {status: 'ok', message: message || '取消成功'}
    else
      render json: {status: 'error', message: message || '操作失败'}
    end
  end

  private
  def set_order
    if params[:action].in? ['info', 'stocks']
      @order = Order.find_by(ID: params[:id])
    else
      @order = Order.includes(:order_score).find_by(OrderCode: params[:id])
    end
  end

  def set_order_group
    @order_group = OrderGroup.find_by(ID: params[:id])
  end

  def order_params
    params.require(:order).permit(:Message, :Address, :ShipName, :ShipTel, :IsHaveInvoice, :InvoiceTitle, :CouponCode, :PayType, :InvitationCode,:CashVolume)
  end

  def authority_verify!
    order = @order || @order_group
    if order != nil && order.UserID != current_user.ID
      respond_to do |format|
        format.html { redirect_to orders_users_path }
        format.json { render json: {status: 'error', message: '没有权限'} }
      end
    end
  end


end

