# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'yaml'


meta_file = File.join(File.dirname(File.realdirpath(__FILE__)), 'packages.yml')
file = File.open(meta_file)
meta_info = YAML.load(file)
file.close

meta_info["categories"].each_pair do |category_name, category_info|
  category = Category.create(name: category_name,
                             description: category_info['description'])

  category_info['packages'].each do |package|
    package_info = meta_info['packages'][package]
    Package.create(name: package,
                   category_id: category.id,
                   description: package_info['description'],
                   pypi_url: package_info['pypi_url'],
                   documentation_url: package_info['documentation_url'],
                   source_code_url: package_info['source_code_url'],
                   bug_tracker_url: package_info[' bug_tracker_url'])
  end
end
