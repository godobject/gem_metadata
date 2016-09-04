require 'rspec/collection_matchers'
require 'temporary_directory'

World(GodObject::TemporaryDirectory::Helper.new(name_prefix: 'gem_metadata_cucumber'))
