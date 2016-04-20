class Pricenometry::Record < Pricenometry::Base
  def initialize(container, id, options = {})
    @container = container
    @id = id
    @options = options
  end

  def url type = nil
    @url = URI.escape(Pricenometry::Base::ENDPOINT + '/v1/' + @container + '/' + @id + "/#{type}?" + params.merge(@options).merge(social: true).to_query)
  end

  def record crawl = true
    @options = @options.merge(fetch: crawl)
    url
    json[:result]
  rescue
    nil
  end

  def history
    url 'history'
    json[:result][:history]
  rescue
    nil
  end

  def related
    url 'related'
    json[:result][:related]
  rescue
    nil
  end

  def videos
    url 'videos'
    json[:result][:videos]
  rescue
    nil
  end

  def news
    url 'news'
    json[:result][:news]
  rescue
    nil
  end

  def references
    url 'references'
    json[:result][:references]
  rescue
    nil
  end

  def links
    url 'links'
    json[:result][:links]
  rescue
    nil
  end
end
