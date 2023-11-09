require 'logger'

class DownloadError < StandardError
  def initialize(error='Something went wrong')
    logger = Logger.new('picture_corp.log')
    logger.error error
    super(error)
  end
end
