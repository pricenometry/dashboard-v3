class Pricenometry::Counts < Pricenometry::Base
  def initialize
    @url = URI.escape(Pricenometry::Base::ENDPOINT + '/v1?' + params.to_query)
  end

  def counts
    @counts ||= json[:status]
  end

  def count
    counts[:count]
  end

  def total
    counts[:total]
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
