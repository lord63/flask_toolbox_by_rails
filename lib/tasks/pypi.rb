require 'json'


class PyPIMeta
  def initialize(response)
    @response = JSON.parse(response)
  end

  def download_num
  end

  def release_num
  end

  def current_version
  end

  def released_date
  end

  def first_release
  end

  def python_version
  end
end
