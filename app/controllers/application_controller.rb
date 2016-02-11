class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_page
    params[:page].to_i > 0 ? params[:page].to_i : 1
  end

  def path_without_page
    if path = request.path.match(/(.+?)&page=\d/)
      return path[1]
    else
      return request.path
    end
  end
end
