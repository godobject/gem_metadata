# frozen_string_literal: true

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
