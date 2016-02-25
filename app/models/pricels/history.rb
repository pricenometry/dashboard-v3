class Pricels::History < Pricels::Base
  def initialize(container, id, options = {})
    @url = URI.escape(Pricels::Base::ENDPOINT + '/v1/' + container + '/' + id + '/history?' + params.merge(options).merge(social: false, results: 15).to_query)
  end

  def history
    json[:result]
  end
end
