Feature: Finding gems with matching metadata

  Scenario: Two gem dependencies without matching metadata
    Given a dependency to a gem called "first_without_metadata" with the following gemspec:
    """
    Gem::Specification.new do |gem|
      gem.name = 'first_without_metadata'
      gem.version = '1.0.0'

      gem.summary = 'A gem which does not contain specific metadata'
      gem.description = <<~DESCRIPTION
        This serves as an example for a gem NOT containing specific metadata
        expected by the gem_metadata library.
      DESCRIPTION

      gem.authors = %w{somebody}
      gem.email = %w{somebody@example.org}
      gem.homepage = 'http://example.org'
    end
    """
    And a dependency to a gem called "second_without_metadata" with the following gemspec:
    """
    Gem::Specification.new do |gem|
      gem.name = 'second_without_metadata'
      gem.version = '1.0.0'

      gem.summary = 'A gem which does not contain specific metadata'
      gem.description = <<~DESCRIPTION
        This serves as an example for a gem NOT containing specific metadata
        expected by the gem_metadata library.
      DESCRIPTION

      gem.authors = %w{somebody}
      gem.email = %w{somebody@example.org}
      gem.homepage = 'http://example.org'
    end
    """
    When the following code is executed:
    """
    require 'gem_metadata'

    metadata_service = GodObject::GemMetadata::Service.new

    metadata_service.find_gems_providing('some key')
    """
    Then the result lists none of the gems

  Scenario: One gem dependency with matching metadata and one without
    Given a dependency to a gem called "with_metadata" with the following gemspec:
    """
    Gem::Specification.new do |gem|
      gem.name = 'with_metadata'
      gem.version = '1.0.0'

      gem.summary = 'A gem containing specific metadata'
      gem.description = <<~DESCRIPTION
        This gem serves as an example for a gem containing specific metadata
        expected by the gem_metadata library.
      DESCRIPTION

      gem.authors = %w{somebody}
      gem.email = %w{somebody@example.org}
      gem.homepage = 'http://example.org'

      gem.metadata = {
        'some key' => 'some value'
      }
    end
    """
    And a dependency to a gem called "without_metadata" with the following gemspec:
    """
    Gem::Specification.new do |gem|
      gem.name = 'without_metadata'
      gem.version = '1.0.0'

      gem.summary = 'A gem which does not contain specific metadata'
      gem.description = <<~DESCRIPTION
        This serves as an example for a gem NOT containing specific metadata
        expected by the gem_metadata library.
      DESCRIPTION

      gem.authors = %w{somebody}
      gem.email = %w{somebody@example.org}
      gem.homepage = 'http://example.org'
    end
    """
    When the following code is executed:
    """
    require 'gem_metadata'

    metadata_service = GodObject::GemMetadata::Service.new
    
    metadata_service.find_gems_providing('some key')
    """
    Then the result lists solely the gem named "with_metadata"

  Scenario: Two gem dependencies without matching metadata
    Given a dependency to a gem called "first_with_metadata" with the following gemspec:
    """
    Gem::Specification.new do |gem|
      gem.name = 'first_with_metadata'
      gem.version = '1.0.0'

      gem.summary = 'A gem containing specific metadata'
      gem.description = <<~DESCRIPTION
        This gem serves as an example for a gem containing specific metadata
        expected by the gem_metadata library.
      DESCRIPTION

      gem.authors = %w{somebody}
      gem.email = %w{somebody@example.org}
      gem.homepage = 'http://example.org'

      gem.metadata = {
        'some key' => 'some value'
      }
    end
    """
    And a dependency to a gem called "second_with_metadata" with the following gemspec:
    """
    Gem::Specification.new do |gem|
      gem.name = 'second_with_metadata'
      gem.version = '1.0.0'

      gem.summary = 'A gem containing specific metadata'
      gem.description = <<~DESCRIPTION
        This gem serves as an example for a gem containing specific metadata
        expected by the gem_metadata library.
      DESCRIPTION

      gem.authors = %w{somebody}
      gem.email = %w{somebody@example.org}
      gem.homepage = 'http://example.org'

      gem.metadata = {
        'some key' => 'other value'
      }
    end
    """
    When the following code is executed:
    """
    require 'gem_metadata'

    metadata_service = GodObject::GemMetadata::Service.new

    metadata_service.find_gems_providing('some key')
    """
    Then the result lists the gems named "first_with_metadata" and "second_with_metadata"
