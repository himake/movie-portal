class WishesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_wishable

  def create
    current_user.add_wish_to(@wishable)

    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render layout: false }
    end
  end

  def destroy
    current_user.remove_wish_from(@wishable)

    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render layout: false }
    end
  end

  private

  def set_wishable
    @wishable = Movie.find(params[:movie_id]) unless params[:movie_id].nil?
    @wishable = Serial.find(params[:serial_id]) unless params[:serial_id].nil?
    @wishable
  end
end
