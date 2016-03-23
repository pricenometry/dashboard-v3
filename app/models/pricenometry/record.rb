class Pricenometry::Record < Pricenometry::Base
  def initialize(container, id, options = {})
    @container = container
    @id = id
    @options = options
  end

  def url type = nil
    @url = URI.escape(Pricenometry::Base::ENDPOINT + '/v1/' + @container + '/' + @id + "/#{type}?" + params.merge(@options).to_query)
  end

  def record crawl = true
    @options = @options.merge(fetch: crawl, social: true)
    url
    json[:result]
  end

  def history
    url 'history'
    json[:result][:history]
  end

  def videos
    url 'videos'
    json[:result][:videos]
  end

  def news
    url 'news'
    json[:result][:news]
  end

  def references
    url 'references'
    json[:result][:references]
  end

  def links
    url 'links'
    json[:result][:links]
  end
end
