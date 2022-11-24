class IndexController < ApplicationController
  def index
    get_films
    get_movies_with_trailers
    get_tv_serials
    get_seasons_with_trailers
  end

  private

  def get_films
    @movies = Movie.where(release_date: DateTime.new(2020)..Time.now).order(release_date: :desc).take(25)
  end

  def get_movies_with_trailers
    ids = Movie.last(10).map {|movie| {movie.id => movie.video_key} if movie.video_key != ""}.compact.map{|h| h.each_key.first}
    @movies_with_trailers = Movie.find(ids)
  end

  def get_tv_serials
    @tv_serials = Serial.take(25)
  end

  def get_seasons_with_trailers
    ids = Season.last(10).map {|movie| {movie.id => movie.video_key} if movie.video_key != ""}.compact.map{|h| h.each_key.first}
    @seasons_with_trailers = Season.find(ids)
  end
end
