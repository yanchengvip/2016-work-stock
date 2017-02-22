class HomeController < ApplicationController
  # skip_before_filter :authenticate_user!, only: [:index, :location, :welcome, :parse_location, :gift_bag]

  # skip_before_filter :authenticate_user!, only: [:location, :welcome, :parse_location, :gift_bag]
  # before_filter :authenticate_user!, only: [ :location ]

  skip_before_filter :authenticate_user!, only: [:welcome, :gift_bag]
  skip_before_filter :set_area, only: [:location]

  def index
    render :layout => false if !from_mobile?
    cookies.permanent[:share_code] = params[:share_code] if params[:share_code].present?
    # company_id = cookies[:company_id] || City.beijing.CompanyID
    company_id = session[:company_id] || City.beijing.CompanyID
  	if from_mobile?
      @floors = HFloor.includes(:floor_items).joins("left join HPageConfigs hpc on hpc.ID = HFloors.HPageConfigID").where("hpc.IsEnabled = true and hpc.CompanyID = ? and hpc.TerminalType = 1 and hfloors.IsEnabled = true", company_id).order("Sort")
  	else
      @floors = HFloor.includes(:floor_item).joins("left join HPageConfigs hpc on hpc.ID = HFloors.HPageConfigID").where("hpc.IsEnabled = true and hpc.CompanyID = ? and hpc.TerminalType = 0 and hfloors.IsEnabled = true", company_id).order("Sort")
    end
  end

  def recommend
    floor = HFloor.find_by(ID: params[:floor_id])
    floor_item = floor.floor_item
    @item_products = floor_item && floor_item.products(session[:depot_ids]).page(params[:page]).per(6)
    @item_products ||= []
  end

  def welcome
  end

  def location
    # if current_user && current_user.addresses.length != 0
    #   @cities = []
    # end
    @county_names = []

  end

  def parse_location
    city = City.find_by( CityName: params[:city_name] )
    if city
      county = County.joins("left join Cities c on c.ID = Counties.CityID").where("Counties.CountyName = ? and c.CityName = ?", params[:county_name], params[:city_name]).first
      dsc = DepotSendCounty.find_by(CountyID: county.ID)
      render json: {status: 'ok', data: {company_id: city.CompanyID, depot_id: dsc.DepotID}}
    else
      render json: {status: 'error', message: '暂不支持您所在的地区，请手动选择下列城市、地区'}
    end

    # city = City.joins("left join Provinces p on p.ID = Cities.ProvinceID").where("Cities.CityName = ? and p.ProvinceName = ?", params[:city_name], params[:province_name]).first
    # if city
    #   county = County.joins("left join Cities c on c.ID = Counties.CityID").where("Counties.CountyName = ? and c.CityName = ?", params[:county_name], params[:city_name]).first
    #   dsc = DepotSendCounty.find_by(CountyID: county.ID)
    #   render json: {status: 'ok', data: {company_id: city.CompanyID, depot_id: dsc.DepotID}}
    # else
    #   render json: {status: 'error', message: '暂不支持您所在的地区，请手动选择下列城市、地区'}
    # end
  end

  def gift_bag
    gift_bag = GiftBag.find_by(CompanyID: current_user.CompanyID, State: 1, Status: 2,Type: 0 )
    # gift_bag = GiftBag.find_by(CompanyID: cookies[:company_id], State: 1, Status: 2,Type: 0 )
    if gift_bag
      render json: {status: 'ok', data: {money: gift_bag.Money}}
    else
      render json: {status: 'error'}
    end

  end
end
