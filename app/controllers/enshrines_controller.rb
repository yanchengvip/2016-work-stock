class EnshrinesController < ApplicationController

  def index
    @enshrines = sign_in? ? current_user.enshrines.includes(:product => [:product_info]) : []
    redirect_to sign_in_path if !sign_in? and request.format == 'html'
  end

  def create
    if params[:ids].size == 1 and Enshrine.find_by(ProductID: params[:ids].first, UserID: current_user.id)
      render json: {status: 'error', message: '该商品已存在收藏夹'}
    elsif current_user.add_to_favorites(params[:ids])
      render json: {status: 'ok'}
    else
      render json: {status: 'error', message: '操作失败'}
    end
  end

  def destroy
    enshrine = Enshrine.find_by(ID: params[:id], UserID: current_user.id)
    if !enshrine or enshrine.destroy
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
end
