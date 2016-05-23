class RecordController < ApplicationController
  def index
    if params[:container].presence && params[:record_id].presence

      if browser.bot? #|| !user_signed_in?
        if result(false)[:error]
          redirect_to root_path
        else
          @query = result[:name]
          canonical_details
        end
      else
        threads = [ :result,
                    :history,
                    :related,
                    # :references,
                    # :news,
                    # :links,
                    # :videos,
                  ].map do |thread|
          Thread.new(thread) do |thread|
            send(thread)
          end
        end

        if request.referer.presence && url = URI(request.referer)
          if url.query
            params = CGI.parse(url.query)
            @query = params["query"].presence.try(:first) || params["q"].presence.try(:first) || params["p"].presence.try(:first)
          end
        end

        threads.each(&:join)

        if result[:error]
          if @query.presence
            redirect_to search_path(query: @query)
          else
            redirect_to root_path
          end
        else
          unless result[:available]
            redirect_to search_path(query: result[:name])
          else
            threads = [ :min_price,
                        :max_price,
                        :social_charts,
                        :canonical_details
                      ].map do |thread|
              Thread.new(thread) do |thread|
                send(thread)
              end
            end

            threads.each(&:join)
          end
        end
      end

      prepare_meta_tags title: "Realtime Pricing Trends for " + result[:name].to_s,
                        description: "Get up to the minute " + result[:name].to_s +  " price history and analysis as well as social network popularity, product videos, news trends and more only at Pricenometry.com",
                        og: { title: "Realtime Pricing Trends for " + result[:name].to_s,
                              image: result[:image] },
                        twitter: { description: "Realtime Pricing Trends for " + result[:name].to_s,
                                   image: result[:image],
                                   card: "summary_large_image" },
                        image: result[:image]
    end
  end

  protected

  def social_charts
    @social_charts ||= begin
      chart = []
      chart << {name: 'facebook', data: @history[:facebook_shares]} if @history[:facebook_shares].presence
      chart << {name: 'google plus', data: @history[:google_plus_shares]} if @history[:google_plus_shares].presence
      chart << {name: 'twitter', data: @history[:twitter_shares]} if @history[:twitter_shares].presence
      chart << {name: 'reddit', data: @history[:reddit_shares]} if @history[:reddit_shares].presence
      chart << {name: 'linkedin', data: @history[:linkedin_shares]} if @history[:linkedin_shares].presence
      chart << {name: 'pinterest', data: @history[:pinterest_shares]} if @history[:pinterest_shares].presence
      chart << {name: 'buffer', data: @history[:buffer_shares]} if @history[:buffer_shares].presence
      chart << {name: 'stumbleupon', data: @history[:stumbleupon_shares]} if @history[:stumbleupon_shares].presence
      chart
    rescue => e
      []
    end
  end

  def canonical_details
    @canonical_details ||= [
                            :id,
                            :container,
                            :name,
                            :upc,
                            :model,
                            :availability,
                            :sku,
                            :mpn,
                            :manufacturer
                           ]
  end

  def record
    @record ||= Pricenometry::Record.new(params[:container], params[:record_id])
  end

  def history
    @history ||= record.history || {}
  end

  def min_price
    @min_price ||= begin
      history[:price].try(:values).try(:min_by).try(:min) - 1
    rescue
      history[:price].try(:values).try(:min_by).try(:min)
    rescue
      0
    end
  end

  def max_price
    @max_price ||= begin
      history[:price].try(:values).try(:min_by).try(:max) + 1
    rescue
      history[:price].try(:values).try(:min_by).try(:max)
    rescue
      0
    end
  end

  def result(crawl = true)
    @result ||= record.record(crawl)
  end

  def related
    @related ||= record.related
  end

  def news
    @news ||= record.news
  end

  def videos
    @videos ||= record.videos
  end

  def references
    @references ||= record.references
  end

  def links
    @links ||= record.links
  end
end
