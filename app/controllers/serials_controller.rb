class SerialsController < ApplicationController
  before_action :set_serial, only: %i[show like unlike]
  before_action :set_serials, only: [:show]

  def index
    @serials = Serial.all
  end

  def show
    get_seasons
    get_comments
  end

  private

  def set_serial
    @serial ||= Serial.find(params[:id])
  end

  def set_serials
    @serials ||= Serial.all.where(category: @serial.category).where.not(id: @serial.id)
  end

  def get_seasons
    @seasons ||= @serial.seasons
  end

  def get_comments
    @comments = Kaminari.paginate_array(@serial.comments).page(params[:page]).per(4)
  end
end
