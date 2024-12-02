# frozen_string_literal: true
require_relative 'day00'

class Day01 < Day00
  # @param version_identifier [String]
  # @return [String]
  protected def compute_part_one_solution(version_identifier)
    distance = 0
    lft, rgt = self.load_locations_list(@@part_one_identifier, version_identifier).each { |x| x.sort! }

    lft.each_with_index do |a, i|
      distance += (a - rgt[i]).abs
    end

    distance.to_s
  end

  # @param version_identifier [String]
  # @return [String]
  protected def compute_part_two_solution(version_identifier)
    similarity_score = 0
    lft, rgt = self.load_locations_list(@@part_one_identifier, version_identifier)

    lft.each do |a|
      similarity_score += a * rgt.select { |b| b == a }.count
    end

    similarity_score.to_s
  end

  # @param part_identifier [String]
  # @param version_identifier [String]
  # @return [[Array<Integer>, Array<Integer>]]
  private def load_locations_list(part_identifier, version_identifier)
    lft, rgt = [], []

    self.input_data_as_lines(part_identifier, version_identifier).each do |line|
      a, b = line.split.map { |x| x.to_i }
      lft << a and rgt << b
    end

    [lft, rgt]
  end
end
