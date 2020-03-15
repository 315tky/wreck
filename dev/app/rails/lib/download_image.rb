#!/bin/env ruby

require 'open-uri'
require 'mini_magick'

class DownloadImage

  def initialize
    corporation_id = 98473505 # !! fix me and set me by env var
    @character_ids = Character.character_ids_by_corp(corporation_id)
    @dir = "app/assets/images/"
  end

  def build_urls
    urls = @character_ids.map { |id| "https://images.evetech.net/characters/#{id}/portrait?size=256"}
  end

  def each_url
    build_urls.each { |url| image_download(url, "#{@dir}" + "#{url.split('/')[4]}" + ".jpeg") }
  end

  def image_download(url, target)
    image = MiniMagick::Image.open(url)
    image.resize "256x256"
    image.write(target)
   end

end
