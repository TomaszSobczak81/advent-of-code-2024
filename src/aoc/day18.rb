# frozen_string_literal: true
require_relative 'day00'

class Day18 < Day00
  protected def compute_part_one_solution(version_identifier)
    bytes = version_identifier == @@test_version_identifier ? 12 : 1024
    limit = version_identifier == @@test_version_identifier ? 6 : 70

    @grid = Array.new(limit + 1) { Array.new(limit + 1, '.') }
    self.predict_fallen_bytes(@@part_one_identifier, version_identifier, bytes)
    self.find_shortest_path(limit).to_s
  end

  protected def compute_part_two_solution(version_identifier)
    bytes = self.input_data_as_lines(@@part_one_identifier, version_identifier)
    limit = version_identifier == @@test_version_identifier ? 6 : 70

    bytes.each_with_index do |line, i|
      @grid = Array.new(limit + 1) { Array.new(limit + 1, '.') }
      self.predict_fallen_bytes(@@part_one_identifier, version_identifier, i + 1)

      begin
        self.find_shortest_path(limit)
      rescue
        return line
      end
    end
  end

  private def predict_fallen_bytes(part_identifier, version_identifier, number_of_bytes)
    bytes = self.input_data_as_lines_of_integers(part_identifier, version_identifier, ',')
    bytes[0...number_of_bytes].each { |x, y| @grid[y][x] = '#' }
  end

  private def find_shortest_path(limit)
    @grid[0][0] = 'S'
    @grid[-1][-1] = 'E'
    @queue = [[0, 0, 0]]
    @visited = Set.new

    while @queue.any?
      x, y, steps = @queue.shift
      return steps if @grid[y][x] == 'E'

      [[x - 1, y], [x + 1, y], [x, y - 1], [x, y + 1]].each do |dx, dy|
        next if dx < 0 || dy < 0 || dx > limit || dy > limit
        next if @grid[dy][dx] == '#' || @visited.include?([dx, dy])

        @queue << [dx, dy, steps + 1]
        @visited.add([dx, dy])
      end
    end

    raise 'No path found'
  end
end
