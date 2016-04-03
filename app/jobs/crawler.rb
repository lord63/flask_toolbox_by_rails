require_relative 'github_parser'
require_relative 'pypi_parser'
require 'rest-client'

class Crawler
  def self.get_pypi_info(url)
    response = RestClient.get "#{url}/json"
    PyPIMeta.new response
  end

  def self.get_github_info(url)
    response = RestClient.get url
    GithubMeta.new(response, url)
  end
end
