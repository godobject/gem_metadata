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

module SeparateEnvironmentEvaluation
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

  def evaluation_result
    @evaluation_result ||= @execution_result.object_output
  end

  def write_code_as_function_into_file(code)
    code_file = temporary_directory / 'code.rb'
    code_file.write(<<~CODE)
      def code_to_execute
        #{code}
      end
    CODE

    code_file
  end

  def evaluate_in_separate_environment(command)
    output = execute_in_separate_environment(command)

    @execution_result = ObjectExecutionResult.new(console_output: output)
  end
end

World(SeparateEnvironmentEvaluation)
