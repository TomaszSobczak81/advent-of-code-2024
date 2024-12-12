# frozen_string_literal: true
require_relative 'day00'

class Day11 < Day00
  # @param version_identifier [String]
  # @param blinks [Integer]
  # @return [String]
  protected def compute_part_one_solution(version_identifier, blinks = 25)
    stones = self.input_data_as_lines(@@part_one_identifier, version_identifier)[0].split
    unique = stones.uniq.map { |stone| [stone, 1] }.to_h

    blinks.times do |i|
      _unique = Hash.new(0)

      unique.keys.each do |stone|
        occurences = unique[stone]

        if stone == "0"
          _unique["1"] += occurences
        elsif stone.length.even?
          stone.split('').each_slice(stone.length.to_i / 2).map { |s| s.join.to_i.to_s }.to_a.each { |s| _unique[s] += occurences }
        else
          _unique[(stone.to_i * 2024).to_s] += occurences
        end
      end

      unique = _unique
    end

    unique.values.sum.to_s
  end

  # @param version_identifier [String]
  # @return [String]
  protected def compute_part_two_solution(version_identifier)
    self.compute_part_one_solution(version_identifier, 75)
  end
end
