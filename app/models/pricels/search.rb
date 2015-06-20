class Pricels::Search
  def initialize query
    return nil if query.nil?
    @url = URI.escape('http://api.pricels.com/v1/search/' + query + '?' + params)
  end

  def search
    json[:results].sort_by {|h| h[:original_price] || h[:price] }.sort_by {|h| h[:date] }.reverse
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
    { access_token: api_key,
      crawl: false}.to_query
  end
end
