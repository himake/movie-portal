class ActorsController < ApplicationController
  before_action :set_actor, only: [:show]
  
  def show
    @serials = get_serials
  end

  private

  def set_actor
    @actor ||= Actor.find(params[:id])
  end

  def get_serials
    @serials = Array.new
    @actor.seasons.each do |el|
      @serials.push(el.serial)
    end
    @serials
  end
end
