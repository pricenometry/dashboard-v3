class SearchController < ApplicationController
  def index
    @results ||= params[:query] ? Pricels::Search.new(params[:query].gsub('+',' ')).search : []
  end
end
