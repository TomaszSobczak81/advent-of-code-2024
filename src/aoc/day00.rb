# frozen_string_literal: false
require 'benchmark'

class Day00
  @@part_one_identifier = "one"
  @@part_two_identifier = "two"

  @@live_version = "live"
  @@test_version = "test"

  # @param part_one_expected_test_value [String]
  # @param part_two_expected_test_value [String]
  # @return [Void]
  def initialize(part_one_expected_test_value, part_two_expected_test_value)
    @part_one_expected_test_value = part_one_expected_test_value
    @part_two_expected_test_value = part_two_expected_test_value
  end

  # @return [Void]
  def solve
    solve_solution(@@part_one_identifier, @part_one_expected_test_value)
    solve_solution(@@part_two_identifier, @part_two_expected_test_value)
  end

  # @param part_identifier [String]
  # @param expected_test_value [String]
  # @return [void]
  protected def solve_solution(part_identifier, expected_test_value)
    process_test_solution(part_identifier, expected_test_value)
    process_live_solution(part_identifier)
  end

  # @param part_identifier [String]
  # @param expected_result [String]
  # @return [void]
  protected def process_test_solution(part_identifier, expected_result)
    actual_result = compute_solution(part_identifier, @@test_version)

    if actual_result != expected_result
      puts "Test failed for part #{part_identifier}. Expected #{expected_result} but got #{actual_result} instead."
      exit
    end

    puts "Test passed for part #{part_identifier}. Got #{actual_result} as expected."
  end

  # @param part_identifier [String]
  # @return [void]
  protected def process_live_solution(part_identifier)
    result = nil
    duration = Benchmark.realtime do
      result = compute_solution(part_identifier, @@live_version)
    end

    puts "Solution for part #{part_identifier}: #{result.to_s}  took #{duration * 1000} ms."
  end

  # @param part_identifier [String]
  # @return [String]
  protected def compute_solution(part_identifier, version)
    return compute_part_one_solution(version) if part_identifier == @@part_one_identifier
    return compute_part_two_solution(version) if part_identifier == @@part_two_identifier

    raise "Invalid part identifier: #{part_identifier}"
  end

  # @param version [String]
  # @return [String]
  protected def compute_part_one_solution(version)
    raw_input_data(@@part_one_identifier, version).to_s
  end

  # @param version [String]
  # @return [String]
  protected def compute_part_two_solution(version)
    raw_input_data(@@part_two_identifier, version).to_s.reverse
  end

  # @param part_identifier [String]
  # @param version [String]
  # @return [String]
  protected def raw_input_data(part_identifier, version)
    file_path = "#{Dir.pwd}/var/input/#{version}/day#{self.class.name[3..4]}/part_#{part_identifier}.txt"
    File.read(file_path)
  end
end