class RecordController < ApplicationController
  def index
    if params[:container].presence && params[:record_id].presence
      @result = record.record
      if @result[:error]
        render_404
      else
        @query = @result[:name]
      end

      @news = record.news
      @videos = record.videos
      @references = record.references
      @links = record.links

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
end
