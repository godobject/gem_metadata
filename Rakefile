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

require 'bundler/gem_tasks'
require 'rake'
require 'pathname'
require 'yard'
require 'rspec/core/rake_task'
require 'cucumber/rake/task'

RSpec::Core::RakeTask.new
Cucumber::Rake::Task.new

desc 'Run RSpec code examples and Cucumber features'
task test: [:spec, :cucumber]

YARD::Rake::YardocTask.new('doc')

desc 'Removes temporary project files'
task :clean do
  %w(doc/api coverage pkg .yardoc .rbx Gemfile.lock).map{ |name| Pathname.new(name) }.each do |path|
    path.rmtree if path.exist?
  end

  Pathname.glob('*.gem').each(&:delete)
  Pathname.glob('**/*.rbc').each(&:delete)
end

desc 'Opens an interactive console with the project code loaded'
task :console do
  Bundler.setup
  require 'pry'
  require 'gem_metadata'
  Pry.start(GodObject::GemMetadata)
end

task default: :test
