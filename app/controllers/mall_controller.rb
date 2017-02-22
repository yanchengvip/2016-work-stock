class MallController < ApplicationController


  def index
    @point_products = PointProduct.where(IsOpen: true, Status: 0)
  end

  def product_detail
    @point_product = PointProduct.find_by(ID: params[:id])
  end

  def my_point
    @point_histories = current_user.point_histories
  end

  def my_exchange
    @point_orders = current_user.point_orders.includes(:point_product)
  end

  def exchange_detail
    @point_order = PointOrder.find_by(ID: params[:id])
  end

  def exchange
    @point_product = PointProduct.find_by(ID: params[:id], IsOpen: true, Status: 0)
    render json: {status: 'error', message: '该活动已下架'} and return if @point_product.nil?
    point_order, message = current_user.exchange_point_product(@point_product, order_params)
    if point_order
      render json: {status: 'ok', data: {id: point_order.ID}}
    else
      render json: {status: 'error', message: message || '操作失败'}
    end
  end


  def old_lottery
  end

  def lottery
  end

  def lottery_history
    @lottery_history_items = LotteryHistory.where(UserID: current_user.ID).order('CreateTime desc')
  end

  private
  def order_params
    params.require(:point_order).permit(:Address, :Mobile, :Consignee, :Number)
  end


end
