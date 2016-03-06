class RecordController < ApplicationController
  def index
    if params[:container].presence && params[:record_id].presence

      if result[:error]
        render_404
      else
        @query = result[:name]
        threads = [ :news,
                    :videos,
                    # :references,
                    :links ].map do |thread|
          Thread.new(thread) do |thread|
            send(thread)
          end
        end

        threads.each(&:join)
      end

      if user_signed_in?
        @history = record.history
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
