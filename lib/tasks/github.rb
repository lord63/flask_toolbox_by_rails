require 'json'
require 'nokogiri'
require 'rest-client'


module APIRequest
  def send_request(url)
    if ENV.fetch('GITHUB_TOKEN', nil).nil?
      header = {'User-Agent': 'https://github.com/lord63/flask_toolbox_by_rails'}
    else
      header = {
        'User-Agent': 'https://github.com/lord63/flask_toolbox_by_rails',
        'Authorization': "token #{ENV['GITHUB_TOKEN']}"
      }
    end
    RestClient::Request.execute(method: :get, url: url, headers: header)
  end
end


class GithubMeta
  include APIRequest

  def initialize(response, url)
    @doc = Nokogiri::HTML response
    @url = url
  end

  def watchers
    get_num('.social-count', 0)
  end

  def forks
    get_num('.social-count', -1)
  end

  def last_commit
    DateTime.parse @doc.css('time')[0].get_attribute('datetime')
  end

  def contributors
    num = get_num('.text-emphasized', -1)
    if kind_of? Fixnum
      num
    else
      url = get_api_url 'contributors'
      response = send_request(url)
      JSON.parse(response).length
    end
  end

  def commits
    get_num('.text-emphasized', 0)
  end

  def issues
    get_num('.counter', 0)
  end

  def pull_requests
    get_num('.counter', -1)
  end

  def first_commit
    first_commit_page_num = (commits / 35).ceil
    page_url = "#{@url}/commits?page=#{first_commit_page_num}"
    doc = Nokogiri::HTML(RestClient.get page_url)
    DateTime.parse doc.css('time')[-1].get_attribute('datetime')
  end

  def development_activity
    url = get_api_url 'commits'
    response = JSON.parse(send_request url)
    now = DateTime.now
    deltas = response.map do |commit|
      (now - DateTime.parse(commit['commit']['committer']['date'])).to_i
    end
    average_delta = deltas.inject(:+) / response.length
    case average_delta
    when (0..7)
      'Very active'
    when (8..31)
      'Active'
    when (32..365)
      'Less Active'
    else
      'Inactive'
    end
  end

  private

  def get_num(css_expr, index)
    result = @doc.css(css_expr)[index].text
    return result if result.empty?
    custom_int(result)
  end

  def custom_int(string_num)
    string_num.gsub(',', '').to_i
  end

  def get_api_url(type)
    owner, repo = @url.split('/').slice(3, 2)
    url = "https://api.github.com/repos/#{owner}/#{repo}/#{type}"
  end
end
