class Pricels::Record < Pricels::Base
  def initialize(container, id, options = {})
    @url = URI.escape(Pricels::Base::ENDPOINT + '/v1/' + container + '/' + id + '?' + params.merge(options).merge(social: false, results: 15).to_query)
  end

  def record
    json[:result]
  end
end
