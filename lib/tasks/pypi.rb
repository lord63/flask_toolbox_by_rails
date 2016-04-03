require 'json'


class PyPIMeta
  def initialize(response)
    @response = JSON.parse(response)
  end

  def download_num
    @response['urls'].map {|item| item['downloads']}.inject(:+)
  end

  def release_num
    @response['releases'].length
  end

  def current_version
    @response['info']['version']
  end

  def released_date
    DateTime.parse @response['urls'][0]['upload_time']
  end

  def first_release
    releases = @response['releases'].reject {|k, v| v.empty? }
    first_release = releases.sort_by {|k, v| v[0]['upload_time']}[0]
    DateTime.parse first_release[1][0]['upload_time']
  end

  def python_version
    version_string = @response['info']['classifiers'].select do |item|
      item.include?('Programming Language') &&
      item.split(':: ')[-1].length.equal?(3)
    end
    version_string.map {|item| /Python :: (\d\.\d)/.match(item)[1] }.join(' ')
  end
end
