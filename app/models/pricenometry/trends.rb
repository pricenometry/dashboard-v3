class Pricenometry::Trends < Pricenometry::Base
  def initialize(type, container = nil, options = {})
    if container.nil?
      @url = URI.escape(Pricenometry::Base::ENDPOINT + '/v1/trends/' + type + '?' + params.merge(options).merge(social: false, results: 10).to_query)
    else
      @url = URI.escape(Pricenometry::Base::ENDPOINT + '/v1/' + container + '/trends/' + type + '?' + params.merge(options).merge(social: false, results: 10).to_query)
    end
  end

  def trends
    @trends ||= json
  end

  def results
    trends[:results]
  end

  def pagination
    trends[:pagination]
  end
end
