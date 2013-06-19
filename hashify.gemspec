# encoding: utf-8
require File.join([File.dirname(__FILE__), 'lib', 'hashify', 'version.rb'])

Gem::Specification.new do |s|
  s.name              = "hashify"
  s.version           = Hashify::VERSION
  s.summary           = "A simple way to specify the hash/json representation of your object"
  s.description       = "
      With hashify you can specify a line with the methods that will be called to
      create a hash representation of your object. Simple and straightforward.
      "
  s.authors           = ["Pablo Astigrraga"]
  s.email             = ["poteland@gmail.com"]
  s.homepage          = "http://github.com/pote/hashify"
  s.files             = Dir['lib/**/*.rb']
  s.require_paths << 'lib'
  s.license           = "MIT"
  s.add_development_dependency "rspec"
end
