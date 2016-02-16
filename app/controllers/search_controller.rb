class SearchController < ApplicationController
  def index
    if params[:query].presence
      search = object.search
      @results = search.insert(5, google_ad) + [google_ad]
    else
      results = []
    end
    # @results = params[:query] ? (object.search.inject(6, google_ad.first) + google_ad) : []
    @pagination = object.pagination.map do |k,v|
      {k => path_without_page + '?query=' + params[:query] + '&page=' + v.to_s} if v
    end.compact.inject({},:merge)
  end

  protected

  def google_ad
    {container: 'google'}
  end

  def object
    @object ||= Pricels::Search.new(params[:query].gsub('+', ' '), {page: current_page})
  end
end
