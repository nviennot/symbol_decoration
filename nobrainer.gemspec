# encoding: utf-8
$:.unshift File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'symbol_decoration'
  s.version     = '1.1.0'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nicolas Viennot"]
  s.email       = ["nicolas@viennot.biz"]
  s.homepage    = "http://github.com/nviennot/symbol_decoration"
  s.summary     = "Symbol Decoration"
  s.description = "Support for symbol decorations such as where(:field.in => [1,2,3])"
  s.license     = "MIT"

  s.files        = Dir["lib/**/*"] + ['README.md']
  s.require_path = 'lib'
  s.has_rdoc     = false
end
