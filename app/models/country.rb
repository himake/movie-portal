class Country < ApplicationRecord
  has_many :movies_country
  has_many :movies, through: :movies_country
end
