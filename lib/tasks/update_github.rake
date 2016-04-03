namespace :update do
  desc 'Update Github info'
  task :github do
    Package.all.map { |package| UpdateGithubJob.perform_later package }
  end
end
