require "./lib/date_interval/version"

Gem::Specification.new do |spec|
  spec.name          = "date_interval"
  spec.version       = DateInterval::VERSION
  spec.authors       = ["Nando Vieira"]
  spec.email         = ["fnando.vieira@gmail.com"]
  spec.summary       = "Parse date intervals from strings"
  spec.homepage      = "http://github.com/fnando/date_interval"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "parslet"
  spec.add_development_dependency "bundler", ">= 0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest-utils"
  spec.add_development_dependency "pry-meta"
end
