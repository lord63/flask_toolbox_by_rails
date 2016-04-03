namespace :update do
  desc "Update PyPI info"
  task :pypi do
    Package.all.map { |package| UpdatePypiJob.perform_later package }
  end
end
