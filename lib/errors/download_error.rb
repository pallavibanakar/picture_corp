# frozen_string_literal: true

require 'logger'

# DownloadError Super class for all kinds of file download errors
class DownloadError < StandardError
  def initialize(error = 'Something went wrong')
    logger = Logger.new('picture_corp.log')
    logger.error error
    super(error)
  end
end
