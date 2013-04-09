# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-clever/version'

Gem::Specification.new do |gem|
  gem.name          = "omniauth-clever"
  gem.version       = Omniauth::Clever::VERSION
  gem.authors       = ["Carol Nichols"]
  gem.email         = ["cnichols@thinkthroughmath.com"]
  gem.description   = %q{Unofficial OmniAuth strategy for Clever SSO OAuth2 integration}
  gem.summary       = %q{The unofficial strategy for authenticating people using Clever to your application using Clever OAuth2}
  gem.homepage      = "https://github.com/thinkthroughmath/omniauth-clever"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
