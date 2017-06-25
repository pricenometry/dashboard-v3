class TrendsController < ApplicationController
  def index
    if params[:type].presence
      @results = object.results.compact

      @latest = Pricenometry::Trends.new('date').results

      @trackers = @trackers + @results.map {|r| r[:tracker] }

      prepare_meta_tags title: "Realtime Trending Results for " + params[:type],
                      description: "Search for up to the minute trends at Pricenometry.com",
                      og: { title: "Realtime Trending Results for " + params[:type],
                            image: @results.first[:image] },
                      twitter: { description: "Realtime Trending Results for " + params[:type],
                                 image: @results.first[:image],
                                 card: "summary_large_image" },
                      image: @results.first[:image]

      @pagination = object.pagination.map do |k,v|
        {k => path_without_page + '?type=' + params[:type] + '&page=' + v.to_s} if v
      end.compact.inject({},:merge)
    else
      redirect_to root_path
    end
  end

  protected

  def object
    @object ||= Pricenometry::Trends.new(params[:type].gsub('+', '_'), params[:container].presence, {page: current_page})
  end
end

