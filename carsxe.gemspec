# frozen_string_literal: true

require_relative "lib/carsxe/version"

Gem::Specification.new do |spec|
  spec.name = "carsxe"
  spec.version = Carsxe::VERSION
  spec.authors = ["carsxe developer"]
  spec.email = ["devops@carsxe.com"]
  spec.developer = "Omar Welied"
  spec.developer_email = "omar.walied@carsxe.com"
  spec.developer_github = "https://github.com/0marwalied"

  spec.summary = "A Ruby gem for interacting with CarsXE APIs."
  spec.description = "CarsXE Ruby gem provides a simple and efficient way to interact with CarsXE APIs, enabling developers to integrate vehicle data and services into their applications."
  spec.homepage = "https://api.carsxe.com/"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/carsxe/carsxe-ruby-package"
  spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore .github/ .standard.yml])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
