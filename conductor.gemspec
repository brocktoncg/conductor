$:.push File.expand_path("../lib", __FILE__)

require "conductor/version"

Gem::Specification.new do |s|
  s.name        = "conductor"
  s.version     = Conductor::VERSION
  s.authors     = ["Kyle Zarazan"]
  s.email       = ["hello@brocktoncg.com"]
  s.homepage    = "http://brocktoncg.com"
  s.summary     = "Ruby on Rails Content Management System"
  s.description = "Minimalistic Rails CMS System"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~>3.2.8"
  s.add_dependency "gemboree", "~>0.1.2"
  s.add_dependency "awesome_nested_set", "~>2.1.5"

  s.add_development_dependency "sqlite3"
end
