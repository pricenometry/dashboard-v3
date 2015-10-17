class VisitorsController < ApplicationController
  def index
    counts = Pricels::Counts.new
    @available = counts.available
    @indexing = counts.indexing
    @processing = counts.processing
    @pending = counts.pending
  end
end
