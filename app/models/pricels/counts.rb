class Pricels::Counts < Pricels::Base
  def initialize
    @url = URI.escape(Pricels::Base::ENDPOINT + '/v1?' + params.to_query)
  end

  def counts
    @counts ||= json[:status]
  end

  def available
    counts[:available]
  end

  def indexing
    counts[:indexing]
  end

  def processing
    counts[:processing]
  end

  def pending
    counts[:pending]
  end
end
