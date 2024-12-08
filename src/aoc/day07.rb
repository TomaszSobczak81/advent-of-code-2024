# frozen_string_literal: true
require_relative 'day00'

class Day07 < Day00
  # @param version_identifier [String]
  # @return [String]
  protected def compute_part_one_solution(version_identifier, try_concat_operator = false)
    equations = self.load_equations(version_identifier)
    calibration_results = []

    equations.each do |result, numbers|
      if (equation_result = self.compute_equation_result(result, numbers, %w[add mul])).positive?
        calibration_results << equation_result
        next
      end

      calibration_results << self.compute_equation_result(result, numbers, %w[add mul con]) if try_concat_operator
    end

    calibration_results.sum.to_s
  end

  # @param version_identifier [String]
  # @return [String]
  protected def compute_part_two_solution(version_identifier)
    self.compute_part_one_solution(version_identifier, true)
  end

  # @param result [Integer]
  # @param numbers [Array<Integer>]
  # @return [Integer]
  private def compute_equation_result(result, numbers, operators)
    operators.repeated_permutation(numbers.size - 1).map do |ops|
      test_value = ["mul", ops].flatten.zip(numbers).inject(1) do |res, (operator, number)|
        case operator
        when "add" then (res + number).to_i
        when "mul" then (res * number).to_i
        else (res.to_s + number.to_s).to_i
        end
      end

      return result if result == test_value
    end

    0
  end

  # @param version_identifier [String]
  # @return [[Integer, Array<Integer>]]
  private def load_equations(version_identifier)
    equations = []

    self.input_data_as_lines(@@part_one_identifier, version_identifier).each do |line|
      result, numbers = line.split(':')
      equations << [result.to_i, numbers.split.map { |i| i.to_i }]
    end

    equations
  end
end
