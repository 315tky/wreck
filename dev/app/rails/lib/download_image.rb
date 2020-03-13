#!/bin/env ruby

require 'open-uri'
require 'mini_magick'

class DownloadImage

  def initialize(urls, dir)
    @urls = urls
    @dir  = dir
  end

  def each_url
    # feed in urls like 'https://images.evetech.net/characters/95090365/portrait?size=256' in an array
    # need to fix the path for the file write line below
    @urls.each { |url| image_download(url, "#{@dir}" + "#{url.split('/').last}" + ".jpeg") }
  end

  def image_download(url, target)
    image = MiniMagick::Image.open(url)
    image.resize "256x256"
    image.write(target)
   end

end
