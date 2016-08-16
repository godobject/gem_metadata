module GodObject::GemMetadata
  class Service
    def initialize(gems: ::Gem.loaded_specs.values)
      @gems = gems
    end

    def find_gems_providing(metadata_key)
      @gems.select { |gem| gem.metadata.key?(metadata_key) }
    end
  end
end
