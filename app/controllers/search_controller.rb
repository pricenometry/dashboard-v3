class SearchController < ApplicationController
  def index
    if @query = params[:query].presence
      search = object.results.compact

      if search.count <= 5
        @results = search + [google_ad]
      elsif search.count <= 10
        @results = search.insert(3, google_ad) + [google_ad]
      elsif search.count <= 15
        @results = search.insert(3, google_ad).insert(11, google_ad) + [google_ad]
      end
    else
      results = []
    end
    @pagination = object.pagination.map do |k,v|
      {k => path_without_page + '?query=' + params[:query] + '&page=' + v.to_s} if v
    end.compact.inject({},:merge)
  end

  protected

  def google_ad
    {container: 'google'}
  end

  def object
    @object ||= Pricels::Search.new(@query.gsub('+', ' '), {page: current_page})
  end
end
