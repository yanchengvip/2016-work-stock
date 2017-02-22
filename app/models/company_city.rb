class CompanyCity < ActiveRecord::Base
  belongs_to :company, foreign_key: :CompanyID
end
