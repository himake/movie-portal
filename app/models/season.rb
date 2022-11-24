class Season < ApplicationRecord
  belongs_to :serial
  has_many :series
  has_many :seasons_actor
  has_many :actors, through: :seasons_actor

  has_many :comments, as: :commentable

  has_many :likes, as: :likeable
  has_many :liked_users, through: :like
  has_many :wishes, as: :wishable
  has_many :wished_users, through: :wish
  has_many :comments, as: :commentable

  paginates_per 4
end
