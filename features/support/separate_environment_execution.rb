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

module SeparateEnvironmentExecution
  def execute_in_separate_environment(command)
    Bundler.with_clean_env do
      Dir.chdir(temporary_directory) do
        @output = `#{command}`
      end
    end
  end

  def create_gemfile(include_gems: [])
    gemfile = temporary_directory / 'Gemfile'

    gemfile.open('w') do |io|
      io.puts(%(gem 'gem_metadata', path: '#{project_root_directory}'))

      include_gems.each do |gem_name|
        io.puts(%(gem '#{gem_name}', path: '#{gem_name}'))
      end
    end

    gemfile
  end
end

World(SeparateEnvironmentExecution)
