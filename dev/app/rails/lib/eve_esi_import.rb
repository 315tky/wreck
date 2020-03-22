#!/bin/env ruby
require 'swagger_client'
require 'net/http'
require 'uri'
require 'json'

 class EveEsiImport
  attr_reader :session_access_token
  def initialize
    uri = URI.parse("https://login.eveonline.com/oauth/token")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request["Authorization"] = "Basic #{ENV['BASE64_ENCODE']}"
    request.body = JSON.dump({
      "grant_type" => "refresh_token",
      "refresh_token" => "#{ENV['REFRESH_TOKEN']}"
    })
    req_options = {
      use_ssl: uri.scheme == "https",
    }
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    @session_access_token = JSON.parse(response.body)["access_token"]
  end

end
