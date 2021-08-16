Gem::Specification.new do |spec|
  # ...
  spec.name = 'gig'
  spec.version = '0.0.0'
  spec.summary = 'GitHub Image Grep'
  spec.description = 'Command line tool using the GitHub API to download and save avatar images from repository owners matching the search criteria'
  spec.authors = ['Alex-450']
  spec.email = 'alex.wmstearn@gmail.com'
  spec.files = ['lib/gig.rb']
  spec.executables = 'gig'
  spec.license = 'MIT'
  spec.add_development_dependency 'rspec', '~> 3.10.0'
  spec.homepage = 'https://github.com/Alex-450/gig'
  spec.extra_rdoc_files = ['README.md']
end
