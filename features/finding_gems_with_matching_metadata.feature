Feature: Finding gems with matching metadata

  Scenario: Two gem dependencies without matching metadata
    Given a dependency to a gem called "first_without_metadata" without metadata
    And a dependency to a gem called "second_without_metadata" without metadata
    When the following code is executed:
    """
    require 'gem_metadata'

    metadata_service = GodObject::GemMetadata::Service.new

    metadata_service.find_gems_providing('some key')
    """
    Then the result lists none of the gems

  Scenario: One gem dependency with matching metadata and one without
    Given a dependency to a gem called "with_metadata" with the following metadata definition in its gemspec:
    """
      gem.metadata = {
        'some key' => 'some value'
      }
    """
    And a dependency to a gem called "without_metadata" without metadata
    When the following code is executed:
    """
    require 'gem_metadata'

    metadata_service = GodObject::GemMetadata::Service.new
    
    metadata_service.find_gems_providing('some key')
    """
    Then the result lists solely the gem named "with_metadata"

  Scenario: Two gem dependencies without matching metadata
    Given a dependency to a gem called "first_with_metadata" with the following metadata definition in its gemspec:
    """
      gem.metadata = {
        'some key' => 'some value'
      }
    """
    And a dependency to a gem called "second_with_metadata" with the following metadata definition in its gemspec:
    """
      gem.metadata = {
        'some key' => 'other value'
      }
    """
    When the following code is executed:
    """
    require 'gem_metadata'

    metadata_service = GodObject::GemMetadata::Service.new

    metadata_service.find_gems_providing('some key')
    """
    Then the result lists the gems named "first_with_metadata" and "second_with_metadata"
