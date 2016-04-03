require_relative 'worker'

class UpdateGithubJob < ActiveJob::Base
  queue_as :default

  def perform(name)
    Worker.update_package_github_info name
  end
end
