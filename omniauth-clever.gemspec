# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/clever/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-clever"
  spec.version       = Omniauth::Clever::VERSION
  spec.authors       = ["Panorama Education"]
  spec.email         = ["engineering@panoramaed.com"]
  spec.description   = "The Panorama strategy for authenticating people using clever.com using Clever's OAuth2 provider"
  spec.summary       = spec.description
  spec.license       = 'MIT'

  spec.signing_key   = ENV['GEM_PRIVATE_KEY']
  spec.cert_chain    = ['gem-public_cert.pem']

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec_junit_formatter"

  spec.add_dependency "omniauth-oauth2", "= 1.8.0"
end
