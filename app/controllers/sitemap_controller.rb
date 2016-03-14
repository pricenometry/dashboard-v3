class SitemapController < ApplicationController
  def show
    data = open("https://#{Rails.configuration.config[:admin][:domain_name]}-sitemaps.s3.amazonaws.com/sitemaps/sitemap#{params[:id]}.xml.gz")
    ap data
    send_data data.read, :type => data.content_type
  end
end
