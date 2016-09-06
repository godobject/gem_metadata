# frozen_string_literal: true

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
