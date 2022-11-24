class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show like unlike]
  before_action :set_movies, only: [:show]

  def index
    @movies = Movie.all
  end

  def show
    get_actors
    get_comments
  end

  private

  def set_movie
    @movie ||= Movie.find(params[:id])
  end

  def set_movies
    @movies ||= Movie.all.where(category: @movie.category).where.not(id: @movie.id)
  end

  def get_actors
    @actors ||= @movie.actors
  end

  def get_comments
    @comments = Kaminari.paginate_array(@movie.comments).page(params[:page]).per(4)
  end
end
