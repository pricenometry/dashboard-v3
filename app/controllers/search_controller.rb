class SearchController < ApplicationController
  def index
    if @query = params[:query].presence
      @results = object.results.compact

      @latest = Pricenometry::Trends.new('date').results

      @trackers = @trackers + @results.map {|r| r[:tracker] }

      @title = "Realtime Pricing Search Results for " + @query.to_s

      @image = @results.first[:image].to_s

      @ad_query = @query.presence

      prepare_meta_tags title: @title,
                      description: "Search for up to the minute price history and analysis as well as social network popularity, product videos, news trends and more only at Pricenometry.com",
                      og: { title: "Realtime Pricing Search Results for " + @query,
                            image: @results.first[:image] },
                      twitter: { description: "Realtime Pricing Search Results for " + @query,
                                 image: @results.first[:image],
                                 card: "summary_large_image" },
                      image: @image

      @pagination = object.pagination.map do |k,v|
        {k => path_without_page + '?query=' + params[:query] + '&page=' + v.to_s} if v
      end.compact.inject({},:merge)
    else
      redirect_to root_path
    end
  end

  protected

  def object
    @object ||= Pricenometry::Search.new(@query.gsub('+', ' '), {page: current_page})
  end
end
