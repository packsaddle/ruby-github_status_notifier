# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'github_status_notifier/version'

Gem::Specification.new do |spec|
  spec.name          = 'github_status_notifier'
  spec.version       = GithubStatusNotifier::VERSION
  spec.authors       = ['sanemat']
  spec.email         = ['o.gata.ken@gmail.com']

  spec.summary       = 'Notify to GitHub status.'
  spec.description   = 'Easy to handle GitHub status with exit status. Like TravisCI\'s build status.'
  spec.homepage      = 'https://github.com/packsaddle/ruby-github_status_notifier'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.0'

  spec.files         = \
    `git ls-files -z`
      .split("\x0")
      .reject { |f| f.match(%r{^(test|spec|features)/}) }
      .reject do |f|
        [
          '.travis.yml',
          'circle.yml',
          '.tachikoma.yml'
        ].include?(f)
      end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'thor'
  spec.add_runtime_dependency 'saddler-reporter-github'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'test-unit'
end
