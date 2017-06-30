class VisitorsController < ApplicationController
  def index
    @title = "Track and Search Anything Online with a Price Tag in Realtime"

    @image = "https://pricenometry.com" + ActionController::Base.helpers.asset_path("thumbnail.jpg")

    @ad_query = 'Comparison Shopping'

    prepare_meta_tags title: @title,
                      description: "Get up to the minute price history and analysis as well as social network popularity, product videos, news trends and more only at Pricenometry.com",
                      og: { title: "Track Anything Online with a Price Tag in Realtime",
                            image: @image },
                      twitter: { description: "Track Anything Online with a Price Tag in Realtime",
                                 image: @image,
                                 card: "summary_large_image" },
                      image: @image
    counts = Pricenometry::Counts.new
    @count = counts.count
    @total = counts.total
    @available = counts.available
    @indexing = counts.indexing
    @processing = counts.processing
    @pending = counts.pending
  end
end
