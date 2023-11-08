# frozen_string_literal: true
Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each {|file| require file }
require 'open-uri'
require 'pry'

module Services
  class PictureClient
    include Validators
    def initialize; end

    def download_image(url)
      validate_url(url)
      file_name, file_extension = extract_file_details(url)
      image_stream = read_image(url)
      write_to_tempfile(file_name, file_extension, image_stream)
    end

    private

    def read_image(url)
      begin
        URI.open(url) {|image_file|
          image_file.read
        }
      rescue OpenURI::HTTPError => error
        raise FetchImageError, "Failed to fetch image for #{url} with error: #{error.message}"
      end
    end

    def write_to_tempfile(file_name, file_extension, image_stream)
      image_file = Tempfile.open([file_name, file_extension], binmode: true)
      image_file.write(image_stream) if image_stream
      image_file.path
    rescue Errno::ENOENT => error
      raise FileWriteError, error.message
    end

    def validate_url(url)
      raise InvalidUrlError, "Invalid Url #{url}" unless valid_url?(url)
    end

    def extract_file_details(url)
      url_path = URI.parse(url).path
      [url_path.split('/')[-1].split('.')[0], File.extname(url_path)]
    end
  end
end
