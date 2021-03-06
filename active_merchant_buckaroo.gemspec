# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = %q{active_merchant_buckaroo}
  s.version     = "0.3.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Berend"]
  s.email       = ["info@moneybird.com"]
  s.homepage    = ""
  s.summary     = %q{ActiveMerchant extension to support the Dutch PSP Buckaroo}
  s.description = %q{ActiveMerchant extension to support the Dutch PSP Buckaroo}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('activemerchant')
  s.add_dependency('nokogiri')
  s.add_development_dependency('rack')
  s.add_development_dependency('rack-test')
  s.add_development_dependency('rspec')
  s.add_development_dependency('rubocop')
  s.add_development_dependency('rubocop-performance')
  s.add_development_dependency('rubocop-rspec')
  s.add_development_dependency('vcr')
  s.add_development_dependency('webmock')
end
