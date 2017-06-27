class VisitorsController < ApplicationController
  def index
    @title = "Track and Search Anything Online with a Price Tag in Realtime"

    prepare_meta_tags title: @title,
                      description: "Get up to the minute price history and analysis as well as social network popularity, product videos, news trends and more only at Pricenometry.com",
                      og: {title: "Track Anything Online with a Price Tag in Realtime" }
    counts = Pricenometry::Counts.new
    @count = counts.count
    @total = counts.total
    @available = counts.available
    @indexing = counts.indexing
    @processing = counts.processing
    @pending = counts.pending
  end
end
