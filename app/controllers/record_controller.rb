class RecordController < ApplicationController
  def index
    if params[:container].presence && params[:record_id].presence
      @result = record_object.record
      if @result[:error]
        render_404
      else
        @query = @result[:name]
      end
      @history = @history_object.history
    end
  end

  protected

  def render_404
    render(file: "#{Rails.root}/public/404.html", layout: false, status: 404)
  end

  def record_object
    @record ||= Pricels::Record.new(params[:container], params[:record_id])
  end

  def history_object
    @history ||= Pricels::History.new(params[:container], params[:record_id])
  end
end
