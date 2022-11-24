class DirectorsController < ApplicationController
  before_action :set_director, only: [:show]
  def show; end

  private

  def set_director
    @director ||= Director.find(params[:id])
  end
end
