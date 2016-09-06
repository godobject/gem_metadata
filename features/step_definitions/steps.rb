Given(/^a dependency to a gem called "([^"]*)" with the following metadata definition in its gemspec:$/) do |gem_name, gem_metadata_definition|
  gemspec_content = gemspec_for(gem_name: gem_name, additional_content: gem_metadata_definition)

  create_gem_dependency(name: gem_name, gemspec_content: gemspec_content)
end

Given(/^a dependency to a gem called "([^"]*)" without metadata$/) do |gem_name|
  create_gem_dependency(name: gem_name)
end

When(/^the following code is executed:$/) do |code_to_execute|
  create_gemfile(include_gems: gem_dependencies)

  code_file = write_code_as_function_into_file(code_to_execute)

  evaluate_in_separate_environment("bundle exec ruby -r'#{code_file}' -e 'puts Marshal.dump(code_to_execute)'")
end

Then(/^the result lists none of the gems$/) do
  expect(evaluation_result).to eql []
end

Then(/^the result lists solely the gem named "([^"]*)"$/) do |gem_name|
  expect(evaluation_result).to have(1).item
  expect(evaluation_result.first).to be_a Gem::Specification
  expect(evaluation_result.first.name).to eql gem_name
end

Then(/^the result lists the gems named "([^"]*)" and "([^"]*)"$/) do |first_gem_name, second_gem_name|
  expect(evaluation_result).to have(2).items
  expect(evaluation_result[0]).to be_a Gem::Specification
  expect(evaluation_result[0].name).to eql first_gem_name
  expect(evaluation_result[1]).to be_a Gem::Specification
  expect(evaluation_result[1].name).to eql second_gem_name
end
