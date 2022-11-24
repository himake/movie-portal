class SearchController < ApplicationController
  def search
    @q = params[:q]
    @results = params[:q].nil? ? [] : MultySearch.new.search(params[:q]).results
    @results = Kaminari.paginate_array(@results).page(params[:page]).per(3)
  end
end
