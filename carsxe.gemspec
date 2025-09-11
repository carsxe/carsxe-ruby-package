# frozen_string_literal: true

require_relative "lib/carsxe/version"

Gem::Specification.new do |spec|
  spec.name          = "carsxe"
  spec.version       = Carsxe::VERSION
  spec.authors       = ["CarsXE Developer", "Omar Walied"]
  spec.email         = ["devops@carsxe.com", "omar.walied@carsxe.com"]

  spec.summary       = "A Ruby gem for interacting with CarsXE APIs."
  spec.description   = "CarsXE Ruby gem provides a simple and efficient way to interact with CarsXE APIs, enabling developers to integrate vehicle data and services into their applications."

  spec.homepage      = "https://github.com/carsxe/carsxe-ruby-package"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 3.2.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"]     = spec.homepage
  spec.metadata["source_code_uri"]  = "https://github.com/carsxe/carsxe-ruby-package"
  spec.metadata["changelog_uri"]    = "https://github.com/carsxe/carsxe-ruby-package/blob/main/CHANGELOG.md"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[Gemfile .gitignore .github/ .standard.yml])
    end
  end

  # executables live in bin/
  spec.bindir = "bin"
  spec.executables = spec.files.grep(%r{\Abin/}) { |f| File.basename(f) }

  spec.require_paths = ["lib"]
end