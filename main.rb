# frozen_string_literal: true
require './services/picture_client'
require './lib/errors/download_error'

class Main
  def call(urls, dest_path)
    (Logger.new('picture_corp.log').info("No image urls to be downloaded"); return []) if urls && urls.empty?
    client = Services::PictureClient.new(dest_path)
    failed_urls = []
    downloaded_image_paths = urls.each_with_object([]) do |url, downloaded_image_paths|
      begin
        download_image = client.download_image(url)
        downloaded_image_paths.push(download_image.path)
      rescue DownloadError => error
        failed_urls.push(url)
        next
      end
    end
    return [downloaded_image_paths, failed_urls]
  end
end
 