class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  paginates_per 4
end
