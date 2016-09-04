require 'English'
require 'pathname'
require 'tmpdir'
require 'gem_metadata'

class ExecutionResult
  attr_reader :return_value, :console_output

  def initialize(process_status: $CHILD_STATUS, console_output:)
    @process_status = process_status
    @console_output = console_output
  end

  def success?
    @process_status.success?
  end
end

class ObjectExecutionResult < ExecutionResult
  def object_output
    fail "Execution failed" unless success?

    Marshal.load(@console_output)
  end
end

Before do
  @gem_dependencies = []
end

After do
  ensure_absence_of_temporary_directory
end

Given(/^a dependency to a gem called "([^"]*)" with the following gemspec:$/) do |gem_name, gemspec_content|
  gem_directory = temporary_directory / gem_name
  gem_directory.mkdir

  gemspec_file = gem_directory / "#{gem_name}.gemspec"
  gemspec_file.write(gemspec_content)

  @gem_dependencies << gem_name
end

When(/^the following code is executed:$/) do |code_to_execute|
  project_root_directory = Pathname.new(__FILE__)
                             .dirname
                             .parent
                             .parent

  gemfile = temporary_directory / 'Gemfile'
  gemfile.open('w') do |io|
    io.puts %{gem 'gem_metadata', path: '#{project_root_directory}'} 

    @gem_dependencies.each do |gem_name|
      io.puts %{gem '#{gem_name}', path: '#{gem_name}'}
    end
  end

  code_file = temporary_directory / 'code.rb'
  code_file.write <<~CODE
    def code_to_execute  
      #{code_to_execute}
    end
  CODE

  Bundler.with_clean_env do
    Dir.chdir(temporary_directory) do
      @execution_result = ObjectExecutionResult.new(
        console_output: `bundle exec ruby -r'#{code_file}' -e 'puts Marshal.dump(code_to_execute)'`
      )
    end
  end
end

Then(/^the result lists none of the gems$/) do
  object_result = @execution_result.object_output
  expect(object_result).to eql []
end

Then(/^the result lists solely the gem named "([^"]*)"$/) do |gem_name|
  object_result = @execution_result.object_output
  expect(object_result).to have(1).item
  expect(object_result.first).to be_a Gem::Specification
  expect(object_result.first.name).to eql gem_name
end

Then(/^the result lists the gems named "([^"]*)" and "([^"]*)"$/) do |first_gem_name, second_gem_name|
  object_result = @execution_result.object_output
  expect(object_result).to have(2).items
  expect(object_result[0]).to be_a Gem::Specification
  expect(object_result[0].name).to eql first_gem_name
  expect(object_result[1]).to be_a Gem::Specification
  expect(object_result[1].name).to eql second_gem_name
end
