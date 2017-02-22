class Company < ActiveRecord::Base
  self.table_name = 'frameworkcompanies'

  has_many :company_cities, foreign_key: "CompanyID"

  def show_name
    case self.ThirdType
      when 0
        "进货宝自营"
      else
        self.CompanyNameCN
    end
  end

  def self.need_stock? company_id
    !Settings.ignore_stock[company_id]
  end
end
