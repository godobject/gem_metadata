# frozen_string_literal: true

require 'rspec/collection_matchers'
require 'temporary_directory'

World(GodObject::TemporaryDirectory::Helper.new(name_prefix: 'gem_metadata_cucumber'))

After do
  ensure_absence_of_temporary_directory
end
