class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :authenticate_user!

  def create
    @comment = Comment.create(user: current_user, commentable: @commentable,
                              time: Time.now.strftime('%d-%m-%Y %k:%M'), body: comment_params[:body])

    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.js { render layout: false }
    end
  end

  private

  def set_commentable
    @commentable = Movie.find(params[:movie_id]) unless params[:movie_id].nil?
    @commentable = Serial.find(params[:serial_id]) unless params[:serial_id].nil?
    @commentable = Season.find(params[:season_id]) unless params[:season_id].nil?
    @commentable = Season.find(params[:series_id]) unless params[:series_id].nil?
    @commentable
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
