require './lib/errors/invalid_path_error'
require './main'
require 'pry'

namespace :picture_corp do
  include Validators
  desc "Task to download list of images from url in a file"
  task :download_images, [:dest_file_path, :source_file_path] do |task, args|
    args.with_defaults(dest_file_path: '/tmp', source_file_path: './example_source_urls.txt')
    logger = Logger.new('picture_corp.log')
    logger.info("Start of download images")
    dest_path = args[:dest_file_path]
    source_path = args[:source_file_path]
    validate_source_path(source_path)
    urls = read_source_urls(source_path)
    logger.info("Urls to be downloaded are #{urls}")
    downloaded_image_paths, failed_image_urls = Main.new.call(urls, dest_path)
    logger.info("Successful file path of the downloaded url are #{downloaded_image_paths}")
    logger.info("Failed Urls for the given urls to be downloaded are #{failed_image_urls}")
    logger.info("End of download images")
  end
end

def read_source_urls(source_file_path)
  File.read(source_file_path).split
end

def validate_source_path(source_file_path)
  raise InvalidPathError.new("Invalid source path #{source_file_path}") unless File.exist?(source_file_path)
end
