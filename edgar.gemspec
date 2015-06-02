Gem::Specification.new do |s|
  s.name = 'edgar'
  s.version = '0.0.1'
  s.license = 'MIT'
  
  s.homepage = 'https://github.com/aj0strow/edgar'
  s.date = '2015-02-02'
  s.summary = 'sec rss parser'
  s.description = 'it parses the rss feed from the sec edgar data service to get all atom entries'
  s.authors = %w(aj0strow)
  s.email = 'alexaner.ostrow@gmail.com'
  
  s.add_runtime_dependency 'feedjira', '~> 1.6.0'
  s.add_runtime_dependency 'nokogiri', '~> 1.6.6'
  s.add_runtime_dependency 'curb', '~> 0.8'
  
  s.files = `git ls-files`.split(/\n/)
  s.test_files = `git ls-files -- test`.split(/\n/)
end
