class CartsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:acvitity_products, :brief]
  before_filter :set_cart, only: [:update_num, :check, :uncheck]
  skip_before_filter :verify_authenticity_token, only: [:check_all, :uncheck_all]

  def index
    # change by lzh
    @dated_products , @cart_ids , @dated_reasons  = [],[],[]
    # change by lzh

    current_user.check_carts if current_user
    respond_to do |format|
      format.json do
        @carts_group = sign_in? ? current_user.carts_group(session[:depot_ids]) : {}
        @stocks = DepotProductStock.stocks_for(@carts_group.values.flatten.map(&:ProductID), session[:depot_ids])
        @activities = Activity.city_activities(@carts_group.keys, session[:city_id])
      end
      format.html do
        if sign_in?
          @carts_group = current_user.carts_group(session[:depot_ids])
          product_stocks = DepotProductStock.includes(:product).where(ProductID: @carts_group.values.flatten.map(&:ProductID),DepotID: session[:depot_ids] )
          @stocks = Hash[product_stocks.map{|ps| [ps.ProductID, ps]}]
          @activities = Activity.city_activities(@carts_group.keys, session[:city_id])
        else
          redirect_to sign_in_path
        end
      end
    end
  end

  #购物车优化新增接口,change by lzh
  def acvitity_products
    current_user.check_carts if current_user
  end

  def brief
    if !sign_in?
      render json: {status: 'ok', data: {num: 0.00, price: 0.00}}
    else
      render json: {status: 'ok', data: {num: current_user.cart_num.to_i, price: current_user.cart_price.to_f}}
    end
  end

  def create
    status, message = current_user.add_to_carts(cart_params, session[:depot_ids])
    if status
      cart_num, cart_price = current_user.cart_for_nav(session[:depot_ids], session[:company_id])
      render json: {status: 'ok', data: {num: cart_num, price: cart_price}}
    else
      render json: {status: 'error', message: message || '操作失败'}
    end
  end

  def update_num
    @cart = Cart.find_by(UserID: current_user.ID, ProductID: params[:id]) if !@cart
    status, message = current_user.update_carts(@cart, params[:num].to_i, session[:depot_ids])
    if status
      cart_num, cart_price = current_user.cart_for_nav(session[:depot_ids], session[:company_id])
      render json: {status: 'ok', data: {num: cart_num, price: cart_price}}
    else
      render json: {status: 'error', message: message || '操作失败'}
    end
  end

  def destroy
    status, message = current_user.delete_carts(params[:id])
    if status
      respond_to do |format|
        format.html { redirect_to action: 'index' }
        format.json do
          cart_num, cart_price = current_user.cart_for_nav(session[:depot_ids], session[:company_id])
          render json: {status: 'ok', data: {num: cart_num, price: cart_price}}
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to action: 'index' }
        format.json { render json: {status: 'error', message: message || '操作失败'} }
      end
    end
  end

  def destroy_more
    status, message = current_user.delete_carts(params[:ids])
    if status
      respond_to do |format|
        format.html { redirect_to action: 'index' }
        format.json do
          cart_num, cart_price = current_user.cart_for_nav(session[:depot_ids], session[:company_id])
          render json: {status: 'ok', data: {num: cart_num, price: cart_price}}
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to 'index' }
        format.json { render json: {status: 'error', message: message || '操作失败'} }
      end
    end
  end

  def check
    @cart.update_attributes(is_checked: true)
    cart_num, cart_price = current_user.cart_for_nav(session[:depot_ids], session[:company_id])
    render json: {status: 'ok', data: {num: cart_num, price: cart_price}}
  end

  def uncheck
    @cart.update_attributes(is_checked: false)
    cart_num, cart_price = current_user.cart_for_nav(session[:depot_ids], session[:company_id])
    render json: {status: 'ok', data: {num: cart_num, price: cart_price}}
  end

  def check_all
    condition, values = [], []
    if params[:third_type].present?
      condition << "ThirdType = ?"
      values << params[:third_type]
    end
    if params[:company_id].present?
      condition << "CompanyID = ?"
      values << params[:company_id]
    end
    current_user.carts.where(condition.join(" and "), values).update_all(is_checked: true)
    # cart_num, cart_price = current_user.cart_for_nav(cookies[:company_id], session[:company_id])
    cart_num, cart_price = current_user.cart_for_nav(session[:company_id], session[:company_id])
    render json: {status: 'ok', data: {num: cart_num, price: cart_price}}
  end

  def uncheck_all
    condition, values = [], []
    if params[:third_type].present?
      condition << "ThirdType = ?"
      values << params[:third_type]
    end
    if params[:company_id].present?
      condition << "CompanyID = ?"
      values << params[:company_id]
    end
    current_user.carts.where(condition.join(" and "), values).update_all(is_checked: false)
    # cart_num, cart_price = current_user.cart_for_nav(cookies[:company_id], session[:company_id])
    cart_num, cart_price = current_user.cart_for_nav(session[:company_id], session[:company_id])
    render json: {status: 'ok', data: {num: cart_num, price: cart_price}}
  end

  private
  def set_cart
    @cart = Cart.find_by(ID: params[:id])
  end

  def cart_params
    params.require(:cart).permit(:Number, :ProductID)
  end
end
