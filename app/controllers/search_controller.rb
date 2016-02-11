class SearchController < ApplicationController
  def index
    @results = params[:query] ? object.search : []
    @pagination = object.pagination.map do |k,v|
      {k => path_without_page + '?query=' + params[:query] + '&page=' + v.to_s} if v
    end.compact.inject({},:merge)
  end

  protected

  def object
    @object ||= Pricels::Search.new(params[:query].gsub('+', ' '), {page: current_page})
  end
end
