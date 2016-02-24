class RecordController < ApplicationController
  def index
    if params[:container].presence && params[:record_id].presence
      @result = object.record
      if @result[:error]
        render_404
      else
        @query = @result[:name]
      end
    end
  end

  protected

  def render_404
    render(file: "#{Rails.root}/public/404.html", layout: false, status: 404)
  end

  def object
    @object ||= Pricels::Record.new(params[:container], params[:record_id])
  end
end
