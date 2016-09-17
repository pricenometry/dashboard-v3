class Pricenometry::Base
  ENDPOINT = 'https://api.pricenometry.com'

  def json
    JSON.parse(response[:body]).deep_symbolize_keys!
  end

  def response
    Excon.get(@url, :headers => { "Accept" => "gzip" })
  end

  private

  def api_key
    Rails.configuration.config[:pricenometry][:api_key]
  end

  def params
    { access_token: api_key }
  end
end
