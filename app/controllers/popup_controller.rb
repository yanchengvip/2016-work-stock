class PopupController < ApplicationController
  skip_before_filter :authenticate_user!
  # skip_before_filter :set_area
  before_filter :set_area, if: :from_app?

  def index
    @popup_configs = PopupConfig.enabled(session[:city_id], params[:type].to_s.split(",").map(&:to_i))
  end

end
