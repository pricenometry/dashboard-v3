class Pricels::Counts < Pricels::Base
  def initialize
    @url = URI.escape('http://api.pricels.com/v1?' + params)
  end

  def available
    json[:available]
  end

  def indexing
    json[:indexing]
  end

  def processing
    json[:indexing]
  end

  def pending
    json[:indexing]
  end
end
