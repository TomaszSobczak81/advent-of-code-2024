# frozen_string_literal: true
require_relative 'day00'

class Day09 < Day00
  protected def compute_part_one_solution(version_identifier)
    disk = []

    self.input_data_as_lines_of_integers(@@part_one_identifier, version_identifier)[0].each_with_index do |x, i|
      disk.concat((i.even? ? [i / 2] : ['.']) * x)
    end

    p = disk.size - 1
    (disk.size - 1).downto(1).each do |pos|
      next if disk[pos] == '.'

      if (x = disk[0..pos].find_index('.'))
        disk[x] = disk[pos]
        disk[pos] = '.'
      else
        p = pos
        break
      end
    end

    disk[0..p].each_with_index.inject(0) do |res, (block, id)|
      res + block.to_i * id
    end.to_s
  end

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
