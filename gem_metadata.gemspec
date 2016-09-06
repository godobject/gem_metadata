# frozen_string_literal: true
=begin
Copyright Alexander E. Fischer <aef@godobject.net>, 2016

This file is part of GemMetadata.

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
=end

require 'English'
require_relative 'lib/god_object/gem_metadata/version'

Gem::Specification.new do |gem|
  gem.name    = 'gem_metadata'
  gem.version = GodObject::GemMetadata::VERSION.dup
  gem.authors = ['Alexander E. Fischer']
  gem.email   = ['aef@godobject.net']
  gem.description = <<-DESCRIPTION
GemMetadata is a Ruby library that allows to filter and access gems by custom
metadata keys that their specifications contain.
  DESCRIPTION
  gem.summary  = 'Filter and access gems depending on metadata they contain'
  gem.homepage = 'https://www.godobject.net/'
  gem.license  = 'ISC'
  gem.has_rdoc = 'yard'
  gem.extra_rdoc_files  = %w(HISTORY.md LICENSE.md)
  gem.rubyforge_project = nil

  `git ls-files 2> /dev/null`

  if $CHILD_STATUS.success?
    gem.files         = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  else
    gem.files         = `ls -1`.split($OUTPUT_RECORD_SEPARATOR)
  end

  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = %w(lib)

  gem.required_ruby_version = '>= 2.3.0'

  gem.add_development_dependency('rake')
  gem.add_development_dependency('bundler')
  gem.add_development_dependency('rspec', '~> 3.5')
  gem.add_development_dependency('rspec-collection_matchers', '~> 1.1')
  gem.add_development_dependency('cucumber', '~> 2.4')
  gem.add_development_dependency('temporary_directory', '= 0.1.0')
  gem.add_development_dependency('simplecov')
  gem.add_development_dependency('pry')
  gem.add_development_dependency('yard')
  gem.add_development_dependency('kramdown')
end
