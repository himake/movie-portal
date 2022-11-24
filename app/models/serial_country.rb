class SerialCountry < ApplicationRecord
  belongs_to :serial
  belongs_to :actor
end
