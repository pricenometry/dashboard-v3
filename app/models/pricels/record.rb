class Pricels::Record < Pricels::Base
  def initialize(container, id, options = {})
    @container = container
    @id = id
    @options = options
  end

  def url type = nil
    @url = URI.escape(Pricels::Base::ENDPOINT + '/v1/' + @container + '/' + @id + "/#{type}?" + params.merge(@options).merge(social: false).to_query)
  end

  def record
    url
    json[:result]
  end

  def history
    url 'history'
    json[:result]
  end

  def videos
    url 'videos'
    json[:result]
  end

  def news
    url 'news'
    json[:result]
  end

  def references
    url 'references'
    json[:result]
  end

  def links
    url 'links'
    json[:result]
  end
end
