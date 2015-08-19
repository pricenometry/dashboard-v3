class Pricels::Search < Pricels::Base
  def initialize(query)
    return nil if query.nil?
    @url = URI.escape(Pricels::Base::ENDPOINT + '/v1/search/' + query + '?' + params.merge(social: false).to_query)
  end

  def search
    json[:results]
  end
end
