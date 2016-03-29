class SitemapController < ApplicationController
  def show
    @url = "http://#{Rails.configuration.config[:admin][:domain_name]}-sitemaps.s3.amazonaws.com/#{params[:container]}/sitemap#{params[:id]}.xml.gz"
    if params[:container].include?('sitemaps')
      redirect_to root_path
    else
      send_data file.content
    end
  end

  def file
    @file ||= agent.get(@url)
  end

  def agent
    @agent ||= mechanize_defaults
  end

  def mechanize_defaults
    agent = Mechanize.new
    agent.request_headers = { 'Accept-Encoding' => '' }
    agent.keep_alive = false
    agent
  end
end
