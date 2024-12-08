# frozen_string_literal: true
require_relative 'day00'

class Day04 < Day00
  # @param version_identifier [String]
  # @return [String]
  protected def compute_part_one_solution(version_identifier)
    self.search_data(version_identifier).map do |data|
      data.scan(/XMAS/).size + data.reverse.scan(/XMAS/).size
    end.sum.to_s
  end

  # @param version_identifier [String]
  # @return [String]
  protected def compute_part_two_solution(version_identifier)
    lines = self.input_data_as_lines(@@part_one_identifier, version_identifier).map { |a| a.split('') }
    pairs = lines[1..-2].each_with_index.map do |l, i|
      (1...l.length - 1).find_all { |j| l[j] == 'A' }.map { |j| [i + 1, j] }
    end.flatten(1)

    pairs.map do |pair|
      a = lines[pair[0] - 1][pair[1] - 1] + lines[pair[0]][pair[1]] + lines[pair[0] + 1][pair[1] + 1] # diagonal \
      b = lines[pair[0] - 1][pair[1] + 1] + lines[pair[0]][pair[1]] + lines[pair[0] + 1][pair[1] - 1] # diagonal /
      a.match?(/MAS|SAM/) && b.match?(/MAS|SAM/)
    end.count(true).to_s
  end

  # @param version_identifier [String]
  # @return [Array<String>]
  private def search_data(version_identifier)
    raw = self.input_data_as_lines(@@part_one_identifier, version_identifier).map { |a| a.split('') }
    out = raw.dup.map { |a| a.join } # rows
    out.concat(raw.transpose.map { |a| a.join }) # columns

    # Get major diagonals
    out << (0...raw.size).map { |i| raw[i][i] }.join # diagonal \
    out << (0...raw.size).map { |i| raw[i][raw.size - i - 1] }.join # diagonal /

    # Get all minor diagonals
    (1...raw.size).each do |i|
      out << (0...raw.size - i).map { |j| raw[j][j + i] }.join # diagonals over major \
      out << (0...raw.size - i).map { |j| raw[j + i][j] }.join # diagonals under major \
      out << (0...raw.size - i).map { |j| raw[j][raw.size - j - i - 1] }.join # diagonals over major /
      out << (0...raw.size - i).map { |j| raw[j + i][raw.size - j - 1] }.join # diagonals under major /
    end

    out
  end
end
