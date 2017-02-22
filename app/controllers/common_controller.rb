class CommonController < ApplicationController
  skip_before_filter :authenticate_user!, except: [:upload_token, :share_page]
  skip_before_filter :set_area, only: [:mobile_agreement, :mobile_about, :wechat_download, :upload_token, :check_version, :about, :team, :reports, :join_us, :contact_us, :return_picture, :share_page, :position_infoes, :generate_code]
  skip_before_filter :verify_authenticity_token, only: [:share_page]
  layout "common"

  def about
  end

  def after
  end

  def business
  end

  def guide
  end

  def hotline
  end

  def law
  end

  def service
  end

  def join_us
  end

  def reports
    @reports = MediaReport.order("MediaReportDate desc").page(params[:page]).per(20)
  end

  def report_content
    @report = MediaReport.find_by(ID: params[:id])
  end

  def partners
  end

  def contact_us
  end

  def registerxy
    render layout: false
  end

  def wechat_download
    render layout: 'mobile_events'
  end

  def invitation_letter
    render layout: 'mobile_events'
  end

  def mobile_agreement
    render layout: 'mobile'
  end

  def mobile_about
    render layout: 'mobile'
  end

  def team
  end

  def second_page
  end

  def package_page
  end

  def seckill_page
  end

  def second_page_pc
  end

  def way
  end

  def upload_token
    render json: {uptoken: Stock::Qiniu.upload_token}
  end

  def check_version
    @version = AppVersion.find_by(Platform: params[:platform].to_s.downcase, enable: true)
  end

  def cities
    @cities = City.all_cities
  end

  def position_infoes
  end

  #change by lzh
  def return_picture
    @open_screens = OpenScreen.where(IsEnabled: 1)
  end
  #change by lzh

  def share_page
    flag = false
    ActiveRecord::Base.transaction do
      current_user.increment_with_sql!(:Integral, 100)
      PointHistory.create!(UserID: current_user.ID, CurrentPoint: current_user.Integral.to_i, DeltaPoint: 100, Type: 9)
      flag = true
    end
    if flag
      render json: {status: 'ok'}
    else
      render json: {status: 'error', message: "内部错误"}
    end
  end

  def generate_code
    codes = []
    params[:num].to_i.times{|index| codes << CommonHelper.get_order_code}
    render json: {status: 'ok', data: {codes: codes}}
  end
end
