class Pricels::Counts < Pricels::Base
  def initialize
    @url = URI.escape(Pricels::Base::ENDPOINT + '/v1?' + params.to_query)
  end

  def available
    json[:status][:available]
  end

  def indexing
    json[:status][:indexing]
  end

  def processing
    json[:status][:processing]
  end

  def pending
    json[:status][:pending]
  end
end
