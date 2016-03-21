class VisitorsController < ApplicationController
  def index
    prepare_meta_tags title: "Track and Search Anything Online with a Price Tag in Realtime",
                      description: "Get up to the minute price history and analysis as well as social network popularity, product videos, news trends and more only at Pricenometry.com",
                      og: {title: "Track Anything Online with a Price Tag in Realtime" }
    counts = Pricels::Counts.new
    @available = counts.available
    @indexing = counts.indexing
    @processing = counts.processing
    @pending = counts.pending
  end
end
