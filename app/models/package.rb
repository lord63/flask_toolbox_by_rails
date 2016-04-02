class Package < ActiveRecord::Base
  belongs_to :category
  has_one :pypi
end
