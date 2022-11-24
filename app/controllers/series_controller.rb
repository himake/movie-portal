class SeriesController < ApplicationController
  before_action :set_serie, only: %i[show]
  before_action :get_season, only: [:show]

  def show
    set_serial
    get_serials
    get_other_series
    get_comments
  end

  private

  def set_serie
    @serie ||= Series.find(params[:id])
  end

  def get_other_series
    @series ||= Series.all.where(season_id: @serie.season_id).where.not(id: @serie.id)
  end

  def get_season
    @season ||= Season.find(@serie.season_id)
  end

  def set_serial
    @serial = Serial.find(@season.serial_id) 
  end

  def get_serials
    @serials ||= Serial.all.where(category: @serial.category).where.not(id: @serial.id)
  end

  def get_comments
    @comments = Kaminari.paginate_array(@serie.comments).page(params[:page]).per(4)
  end
end
