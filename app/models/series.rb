class Series < ApplicationRecord
  belongs_to :season

  has_many :comments, as: :commentable
end
