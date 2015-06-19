class Pricels::Search
  def initialize query
    return nil if query.nil?
    @url = 'http://api.pricels.com/v1/search/' + query + '?' + params
  end

  def search
    json[:results]
  rescue
    []
  end

  def json
    JSON.parse(response[:body]).deep_symbolize_keys!
  end

  def response
    Excon.get(@url)
  end

  private

  def api_key
    Rails.configuration.config[:pricels][:api_key]
  end

  def params
    {access_token: api_key}.to_query
  end
end
