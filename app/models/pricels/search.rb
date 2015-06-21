class Pricels::Search < Pricels::Base
  def initialize query
    return nil if query.nil?
    @url = URI.escape('http://api.pricels.com/v1/search/' + query + '?' + params)
  end

  def search
    json[:results]
  end
end
