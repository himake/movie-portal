class MoviesActor < ApplicationRecord
  belongs_to :movie
  belongs_to :actor

  paginates_per 4
end
