Gem::Specification.new do |gem|
  gem.name = 'gem_metadata'
  gem.version = '0.1.0'

  gem.summary = 'A gem which does not contain specific metadata'
  gem.description = <<~DESCRIPTION
    This serves as an example for a gem NOT containing specific metadata
    expected by the gem_metadata library.
  DESCRIPTION

  gem.authors = ['Alexander E. Fischer']
  gem.email = %w{aef@godobject.net}
  gem.homepage = 'https://godobject.net'

  gem.add_development_dependency 'cucumber', '~> 2.4'
  gem.add_development_dependency 'rspec', '~> 3.5'
  gem.add_development_dependency 'rspec-collection_matchers', '~> 1.1'
end
