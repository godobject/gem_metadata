# frozen_string_literal: true

module GemDependencies
  def gem_dependencies
    @gem_dependencies ||= []
  end

  def create_gem_dependency(name:, gemspec_content: gemspec_for(gem_name: name))
    gem_directory = temporary_directory / name
    gem_directory.mkdir

    gemspec_file = gem_directory / "#{name}.gemspec"
    gemspec_file.write(gemspec_content)

    gem_dependencies << name

    gem_directory
  end

  def gemspec_for(gem_name:, additional_content: nil)
    <<-GEMSPEC
Gem::Specification.new do |gem|
  gem.name = '#{gem_name}'
  gem.version = '1.0.0'

  gem.summary = 'This serves as an example for a gem.'
  gem.description = 'This serves as an example for a gem.'

  gem.authors = %w{somebody}
  gem.email = %w{somebody@example.org}
  gem.homepage = 'http://example.org'

  #{additional_content}
end
    GEMSPEC
  end
end

World(GemDependencies)
