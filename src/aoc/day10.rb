# frozen_string_literal: true
require_relative 'day00'

class Day10 < Day00
  # @param version_identifier [String]
  # @return [String]
  protected def compute_part_one_solution(version_identifier)
    input_data = self.load_topographic_map(version_identifier)
    trailheads = self.find_trailheads(input_data)

    trailheads.map do |x, y|
      self.find_distinct_scores(input_data, x, y, Set.new)
    end.map { |x| x.size }.sum.to_s
  end

  # @param version_identifier [String]
  # @return [String]
  protected def compute_part_two_solution(version_identifier)
    input_data = self.load_topographic_map(version_identifier)
    trailheads = self.find_trailheads(input_data)

    trailheads.map do |x, y|
      self.find_distinct_trails(input_data, x, y)
    end.sum.to_s

  end

  # @param version_identifier [String]
  # @return [Array<Array<Integer>>]
  private def load_topographic_map(version_identifier)
    self.input_data_as_grid(@@part_one_identifier, version_identifier).map do |row|
      row.map do |cell|
        cell.to_i
      end
    end
  end

  # @param input_data [Array<Array<Integer>>]
  # @return [Array<Array<Integer>>]
  private def find_trailheads(input_data)
    trailheads = []

    input_data.each_with_index do |row, y|
      row.each_with_index.map do |cell, x|
        trailheads << [x, y] if cell == 0
      end
    end

    trailheads
  end

  # @param input_data [Array<Array<Integer>>]
  # @param x [Integer]
  # @param y [Integer]
  # @param scores [Set<Array<Integer>>]
  # @return [Set<Array<Integer>>]
  private def find_distinct_scores(input_data, x, y, scores)
    return scores.add([x, y]) if input_data[y][x] == 9

    [[x - 1, y], [x + 1, y], [x, y - 1], [x, y + 1]].each do |nx, ny|
      next unless nx >= 0 && nx < input_data[0].length
      next unless ny >= 0 && ny < input_data.length
      next unless input_data[ny][nx] == input_data[y][x] + 1

      self.find_distinct_scores(input_data, nx, ny, scores)
    end

    scores
  end

  # @param input_data [Array<Array<Integer>>]
  # @param x [Integer]
  # @param y [Integer]
  # @param trails [Integer]
  # @return [Integer]
  private def find_distinct_trails(input_data, x, y, trails = 0)
    return trails + 1 if input_data[y][x] == 9

    [[x - 1, y], [x + 1, y], [x, y - 1], [x, y + 1]].each do |nx, ny|
      next unless nx >= 0 && nx < input_data[0].length
      next unless ny >= 0 && ny < input_data.length
      next unless input_data[ny][nx] == input_data[y][x] + 1

      trails = self.find_distinct_trails(input_data, nx, ny, trails)
    end

    trails
  end
end
