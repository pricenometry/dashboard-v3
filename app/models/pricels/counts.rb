class Pricels::Counts < Pricels::Base
  def initialize
    @url = URI.escape(Pricels::Base::ENDPOINT + '/v1?' + params.to_query)
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
