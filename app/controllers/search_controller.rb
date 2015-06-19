class SearchController < ApplicationController
  def index
    @results = Pricels::Search.new(params[:query]).search
  end
end
