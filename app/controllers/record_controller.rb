class RecordController < ApplicationController
  def index
    if params[:container].presence && params[:record_id].presence

      if result[:error]
        render_404
      else
        @query = result[:name]
        threads = [ :history,
                    :min_price,
                    :news,
                    :videos,
                    # :references,
                    :links ].map do |thread|
          Thread.new(thread) do |thread|
            send(thread)
          end
        end

        threads.each(&:join)
      end
    end
  end

  protected

  def render_404
    render(file: "#{Rails.root}/public/404.html", layout: false, status: 404)
  end

  def record
    @record ||= Pricels::Record.new(params[:container], params[:record_id])
  end

  def history
    @history ||= record.history || {}
  end

  def min_price
    @min_price ||= history[:price].try(:values).try(:min_by).try(:min)
  end

  def result
    @result ||= record.record
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
