# frozen_string_literal: true
require_relative 'day00'

class Day09 < Day00
  # @param version_identifier [String]
  # @return [String]
  protected def compute_part_one_solution(version_identifier)
    disk = []
    dots = []

    self.input_data_as_lines_of_integers(@@part_one_identifier, version_identifier)[0].each_with_index do |x, i|
      dots.concat((disk.size...disk.size+x).to_a) if i.odd? and x.positive?
      disk.concat((i.even? ? [i / 2] : ['.']) * x)
    end

    while disk.any?('.') do
      next if (x = disk.pop) == '.'
      i = dots.shift
      disk[i] = x
    end

    disk[0...disk.find_index('.')].each_with_index.inject(0) do |res, (block, id)|
      res + block.to_i * id
    end.to_s
  end

  # @param version_identifier [String]
  # @return [String]
  protected def compute_part_two_solution(version_identifier)
    disk = []

    self.input_data_as_lines_of_integers(@@part_one_identifier, version_identifier)[0].each_with_index do |x, i|
      disk << (i.even? ? [i / 2] : ['.']) * x if x.positive?
    end

    ksid = disk.reverse
    ksid.each do |x|
      next if x[0] == '.'
      if (dots = disk.find_index { |a| (a.size >= x.size) && (a[0] == '.') })
        rest = disk[dots].size - x.size
        prev = disk.find_index(x)

        next if dots > prev

        disk[dots] = x
        disk[prev] = ['.'] * x.size
        disk.insert(dots + 1, ['.'] * rest) if rest.positive?
      end
    end

    disk.flatten.each_with_index.inject(0) do |res, (block, id)|
      res + block.to_i * id
    end.to_s
  end
end
