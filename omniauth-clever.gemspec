# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/clever/version'

Gem::Specification.new do |gem|
  gem.name          = "omniauth-clever"
  gem.version       = Omniauth::Clever::VERSION
  gem.authors       = ["Carol Nichols"]
  gem.email         = ["cnichols@thinkthroughmath.com"]
  gem.description   = %q{Unofficial OmniAuth strategy for getclever.com SSO OAuth2 integration}
  gem.summary       = %q{The unofficial strategy for authenticating people using getclever.com to your application using Clever's OAuth2 provider}
  gem.homepage      = "https://github.com/thinkthroughmath/omniauth-clever"
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'omniauth-oauth2', '~> 1.1.1'
end
