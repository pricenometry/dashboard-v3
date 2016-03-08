class Pricels::Search < Pricels::Base
  def initialize(query, options = {})
    return nil if query.nil?
    @url = URI.escape(Pricels::Base::ENDPOINT + '/v1/search/' + query + '?' + params.merge(options).merge(social: false, results: 15).to_query)
  end

  def search
    @search ||= json
  end

  def results
    search[:results]
  end

  def pagination
    search[:pagination]
  end
end
