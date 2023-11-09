# frozen_string_literal: true

require './services/picture_client'
require './lib/errors/download_error'
require 'parallel'

# Main class for picture corp to download images
class Main
  def call(urls, dest_path)
    if urls && urls.empty?
      Logger.new('picture_corp.log').info('No image urls to be downloaded')
      return []
    end
    client = Services::PictureClient.new(dest_path)
    downloaded_image_paths = []
    failed_urls = []
    Parallel.each(urls, in_threads: 3) do |url|
      downloaded_image_paths.push(client.download_image(url)&.path)
    rescue DownloadError
      failed_urls.push(url)
      next
    end
    [downloaded_image_paths, failed_urls]
  end
end
