require 'json'
require 'open-uri'

class Gig
  def initialize(options)
    @query = options.join('+')
    @images_directory = options.join('-')
    @url = "https://api.github.com/search/repositories?q=#{@query}&per_page=100"
  end

  def check_rate_limit
    rate_limit_url = 'https://api.github.com/rate_limit'
    rate_limit_uri = URI.parse(rate_limit_url)
    begin
      rate_limit_serialized = rate_limit_uri.read
      rate_limit_json = JSON.parse(rate_limit_serialized)
      rate_limit_json['resources']['search']['remaining']
    rescue SocketError
      false
    end
  end

  def query_api
    uri = URI.parse(@url)
    @search_serialized = uri.read
    @search_results = JSON.parse(@search_serialized)
  end

  def save_images
    Dir.mkdir @images_directory unless File.directory?(@images_directory)
    results = @search_results['items'].map { |item| item['owner'] }
    results.each do |result|
      if File.exist?("./#{@images_directory}/#{result['login']}.png") == false
        image = URI.parse(result['avatar_url']).open
        File.open("./#{@images_directory}/#{result['login']}.png", 'wb') do |file|
          file.write(image.read)
        end
      end
    end
  end
end
