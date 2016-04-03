require_relative 'crawler'


class Worker
  def self.update_package_pypi_info(package)
    package_info = Crawler.get_pypi_info(package.pypi_url)
    pypi = Pypi.find_by(name: package.name)
    if pypi.nil?
      Pypi.create(
        package_id: package.id,
        name: package.name,
        download_num: package_info.download_num,
        release_num: package_info.release_num,
        current_version: package_info.current_version,
        released_date: package_info.released_date,
        first_release: package_info.first_release,
        python_version: package_info.python_version
      )
    else
      pypi.update(package_info.to_h)
      pypi.save
    end
  end

  def self.update_package_github_info(package)
    repo_info = Crawler.get_github_info(package.source_code_url)
    github = Github.find_by(name: package.name)
    if github.nil?
      Github.create(
        package_id: package.id,
        name: package.name,
        watchers: repo_info.watchers,
        forks: repo_info.forks,
        last_commit: repo_info.last_commit,
        contributors: repo_info.contributors,
        issues: repo_info.issues,
        pull_requests: repo_info.pull_requests,
        development_activity: repo_info.development_activity,
        first_commit: repo_info.first_commit
      )
    else
      github.update(repo_info.to_h)
      github.save
    end
  end
end
