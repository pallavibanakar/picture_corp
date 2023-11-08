# frozen_string_literal: true
require "uri"

module Validators
  def valid_url?(url)
    ((File.extname(url) =~/^(.png|.gif|.jpg)$/ )&&(url =~ /^#{URI::regexp}$/))
  end
end
