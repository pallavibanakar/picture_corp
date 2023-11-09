# frozen_string_literal: true
require "uri"

module Validators
  def valid_path?(dest_path)
    dest_path && File.directory?(dest_path)
  end

  def valid_url?(url)
    url && ((File.extname(url) =~/^(.png|.gif|.jpg)$/ )&&(url =~ /^#{URI::regexp}$/))
  end
end
