class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_likeable

  def create
    current_user.add_like_to(@likeable)

    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render layout: false }
    end
  end

  def destroy
    current_user.remove_like_from(@likeable)

    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render layout: false }
    end
  end

  private

  def set_likeable
    @likeable = Movie.find(params[:movie_id]) unless params[:movie_id].nil?
    @likeable = Serial.find(params[:serial_id]) unless params[:serial_id].nil?
    @likeable
  end
end
