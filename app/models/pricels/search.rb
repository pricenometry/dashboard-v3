class Pricels::Search < Pricels::Base
  def initialize(query, options = {})
    return nil if query.nil?
    @url = URI.escape(Pricels::Base::ENDPOINT + '/v1/search/' + query + '?' + params.merge(options).merge(social: false).to_query)
  end

  def search
    ad = [{container: 'google'}]
    search = json[:results]
    ad + search + ad
  end

  def pagination
    json[:pagination]
  end
end
