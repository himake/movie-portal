class Wish < ApplicationRecord
  belongs_to :wishable, polymorphic: true
  belongs_to :user
end
