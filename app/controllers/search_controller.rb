class SearchController < ApplicationController
  def index
    if @query = params[:query].presence
      @results = object.results.compact

      prepare_meta_tags title: "Realtime Pricing Search Results for " + @query,
                      description: "Search for up to the minute price history and analysis as well as social network popularity, product videos, news trends and more only at Pricenometry.com",
                      og: { title: "Realtime Pricing Search Results for " + @query,
                            image: @results.first[:image] },
                      twitter: { description: "Realtime Pricing Search Results for " + @query,
                                 image: @results.first[:image],
                                 card: "summary_large_image" },
                      image: @results.first[:image]

      @pagination = object.pagination.map do |k,v|
        {k => path_without_page + '?query=' + params[:query] + '&page=' + v.to_s} if v
      end.compact.inject({},:merge)
    else
      redirect_to root_path
    end
  end

  protected

  # def google_ad
  #   {container: 'google'}
  # end

  def object
    @object ||= Pricenometry::Search.new(@query.gsub('+', ' '), {page: current_page})
  end
end
