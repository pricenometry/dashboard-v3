class Pricenometry::Search < Pricenometry::Base
  def initialize(query, options = {})
    return nil if query.nil?
    @url = URI.escape(Pricenometry::Base::ENDPOINT + '/v1/search/' + query + '?' + params.merge(options).merge(social: true, results: 30).to_query)
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
