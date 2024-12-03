# frozen_string_literal: true
require_relative 'day00'

class Day03 < Day00
  # @param version_identifier [String]
  # @return [String]
  protected def compute_part_one_solution(version_identifier)
    self.load_memory_dump(@@part_one_identifier, version_identifier).map do |instruction|
      if (matches = instruction.match(/mul\((\d+),(\d+)\)/))
        a, b = matches.captures.map { |x| x.to_i }
        a * b
      end || 0
    end.sum.to_s
  end

  # @param version_identifier [String]
  # @return [String]
  protected def compute_part_two_solution(version_identifier)
    process_instructions = true
    self.load_memory_dump(@@part_two_identifier, version_identifier).map do |instruction|
      process_instructions = true if instruction.match?(/(do\(\))/)
      process_instructions = false if instruction.match?(/(don't\(\))/)

      if process_instructions && (matches = instruction.match(/mul\((\d+),(\d+)\)/))
        a, b = matches.captures.map { |x| x.to_i }
        a * b
      end || 0
    end.sum.to_s
  end

  # @param part_identifier [String]
  # @param version_identifier [String]
  # @return [Array<String>]
  private def load_memory_dump(part_identifier, version_identifier)
    memory_dump = []

    self.input_data_as_lines(part_identifier, version_identifier).each do |line|
      memory_dump << line.gsub(/(do|don't|mul)/, '\n\1').split('\n')
    end

    memory_dump.flatten
  end
end
