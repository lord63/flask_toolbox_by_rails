require_relative 'worker'

class UpdatePypiJob < ActiveJob::Base
  queue_as :default

  def perform(name)
    Worker.update_package_pypi_info name
  end
end
