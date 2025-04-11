# frozen_string_literal: true

Dir[File.join('./lib', '**', '*.rb')].each { |file| require file }
require 'open-uri'

module Services
  # Picture Client which reads external image and handles download of image
  class PictureClient
    include Validators
    def initialize(dest_path = '/tmp')
      validate_path(dest_path)
      @dest_path = dest_path
    end

    def download_image(url)
      validate_url(url)
      file_name = extract_file_name(url)
      image_stream = read_image(url)
      write_to_tempfile(file_name, image_stream)
    end

    private

    def read_image(url)
      URI.parse(url).open(&:read)
    rescue OpenURI::HTTPError => e
      raise FetchImageError, "Failed to fetch image for #{url} with error: #{e.message}"
    end

    def write_to_tempfile(file_name, image_stream)
      image_file = File.open("#{@dest_path}/#{file_name}", 'wb')
      image_file.write(image_stream) if image_stream
      image_file
    rescue Errno::ENOENT => e
      raise FileWriteError, e.message
    end

    def validate_url(url)
      raise InvalidUrlError, "Invalid Url #{url}" unless valid_url?(url)
    end

    def validate_path(path)
      raise InvalidPathError, "Invalid Path #{path}" unless valid_path?(path)
    end

    def extract_file_name(url)
      URI.parse(url).path.split('/')[-1]
    end
  end
end
