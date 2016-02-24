class RecordController < ApplicationController
  def index
    if params[:container].presence && params[:record_id].presence
      @record = object.record
      if @record[:error]
        render_404
      else
        @query = @record[:name]
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
