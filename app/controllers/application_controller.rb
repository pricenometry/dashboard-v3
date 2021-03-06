class ApplicationController < ActionController::Base
  require 'browser'
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :prepare_meta_tags, if: "request.get?"

  before_action :set_trackers

  def set_trackers
    @trackers ||= []
    if params[:cid].presence
      @trackers << "https://postback.zeroredirect7.com/zppostback/b10d59d1-ed10-11e5-9deb-0ea7743a2ad5?cid=#{params[:cid]}"
    end

    @trackers << "https://beacon.walmart.com/vm/ttap.gif?affpublisherid=SSAm5cSHYzs&affsdkaction=buynow_button_impression&affsdktrack=#{session.id}&veh=aff&affs=sdk&affsdktype=html&affsdkcomp=buynowbutton&colorscheme=blue&sizescheme=default"

    @trackers
  end

  def prepare_meta_tags(options={})
    site_name   = Rails.configuration.config[:site][:name]
    title       = [controller_name, action_name].join(" ")
    description = Rails.configuration.config[:site][:description]
    image       = options[:image] || ActionController::Base.helpers.asset_path('thumbnail.jpg')
    current_url = request.url

    # Let's prepare a nice set of defaults
    defaults = {
      site:        site_name,
      title:       title,
      image:       image,
      description: description,
      # keywords:    %w[web software development mobile app],
      twitter: {
        site_name: site_name,
        site: '@' + Rails.configuration.config[:site][:name],
        card: 'summary',
        description: description,
        image: image
      },
      og: {
        url: current_url,
        site_name: site_name,
        title: title,
        image: image,
        description: description,
        type: 'website'
      }
    }

    options.reverse_merge!(defaults)

    set_meta_tags options
  end

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

  def render_404
    render(file: "#{Rails.root}/public/404.html", layout: false, status: 404)
  end
end
