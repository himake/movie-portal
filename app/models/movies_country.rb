class MoviesCountry < ApplicationRecord
  belongs_to :movie
  belongs_to :country
end
