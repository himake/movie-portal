class SeasonsController < ApplicationController
  before_action :set_season, only: %i[show]
  before_action :set_serial, only: [:show]

  def index
    @seasons = Season.all
  end

  def show
    get_series
    get_actors
    set_serials
    get_serial_seasons
    get_comments
  end

  private

  def set_season
    @season ||= Season.find(params[:id])
  end

  def set_serial
    @serial = Serial.find(@season.serial_id) 
  end

  def set_serials
    @serials ||= Serial.all.where(category: @serial.category).where.not(id: @serial.id)
  end

  def get_serial_seasons
    @seasons = Season.all.where(serial_id: @serial.id).where.not(id: @season.id)
  end

  def get_actors
    @actors = @season.actors
  end

  def get_series
    @series ||= @season.series
  end

  def get_comments
    @comments = Kaminari.paginate_array(@season.comments).page(params[:page]).per(4)
  end
end
