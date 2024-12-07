# frozen_string_literal: true
require_relative 'day00'

class Day06 < Day00
  # @param version_identifier [String]
  # @return [String]
  protected def compute_part_one_solution(version_identifier)
    area = Area.new(self.input_data_as_grid(@@part_one_identifier, version_identifier))
    area.count_visited_locations.to_s
  end

  # @param version_identifier [String]
  # @return [String]
  protected def compute_part_two_solution(version_identifier)
    area = Area.new(self.input_data_as_grid(@@part_one_identifier, version_identifier))
    area.detect_possible_loops.count.to_s
  end
end

class Area
  # @param area [Array<Array<String>>]
  # @return [Area]
  def initialize(area)
    @area = area
    @invalid_location = '#'
    @visited_location = 'X'

    @possible_loops_positions = []
    @visited_positions = []
  end

  private def process_guard_movement!
    guard = self.locate_guard_position

    while true
      break unless self.is_location_inside_area?(*(goto = guard.next_location))
      self.is_location_accessible?(*goto) ? guard.move! : guard.rotate!
      self.mark_location_as_visited(guard.x, guard.y)
    end
  end

  # @return [Integer]
  def count_visited_locations
    self.process_guard_movement!
    @area.flatten.count(@visited_location)
  end

  def detect_possible_loops
    guard = self.locate_guard_position
    shadow = Guard.new(guard.direction, guard.x, guard.y)
    _area = @area.dup

    @possible_loops_positions = Set.new
    @visited_positions = Set.new

    while true
      break unless self.is_location_inside_area?(*(goto = guard.next_location))
      @visited_positions.add(guard.to_s)

      if self.is_location_accessible?(*goto)
        shadow.update!(guard.direction, guard.x, guard.y)
        shadow.rotate!

        pos = _area[goto[1]][goto[0]]
        tmp = Set.new

        _area[goto[1]][goto[0]] = @invalid_location

        while true
          self.fast_forward_guard_to_next_obstacle!(shadow, _area)
          break if self.is_location_outside_area?(shadow.x, shadow.y)

          unless tmp.add?(shadow.to_s)
            @possible_loops_positions.add(goto.to_s)
            break
          end

          shadow.rotate!
        end

        _area[goto[1]][goto[0]] = pos
      end

      self.is_location_accessible?(*goto) ? guard.move! : guard.rotate!
    end

    @possible_loops_positions
  end

  # @param x [Integer]
  # @param y [Integer]
  # @return [Boolean]
  private def is_location_accessible?(x, y)
    @area[y][x] != @invalid_location
  end

  # @param x [Integer]
  # @param y [Integer]
  # @return [Boolean]
  private def is_location_inside_area?(x, y)
    x.between?(0, @area[0].size - 1) && y.between?(0, @area.size - 1)
  end

  # @param x [Integer]
  # @param y [Integer]
  # @return [Boolean]
  private def is_location_outside_area?(x, y)
    x < 0 || y < 0 || x >= @area[0].size || y >= @area.size
  end

  # @return [Guard]
  private def locate_guard_position
    y = @area.find_index { |row| row.include?('^') }
    x = @area[y].find_index('^')

    Guard.new(@area[y][x], x, y)
  end

  # @param guard [Guard]
  private def fast_forward_guard_to_next_obstacle!(guard, area = @area)
    gx, gy = guard.x, guard.y

    if guard.direction == '>'
      area[gy][gx + 1..].each_with_index do |cell, i|
        return guard.fast_forward!(gx + i, gy) if cell == @invalid_location
      end
    end

    if guard.direction == '<'
      area[gy][0...gx].reverse.each_with_index do |cell, i|
        return guard.fast_forward!(gx - i, gy) if cell == @invalid_location
      end
    end

    if guard.direction == '^'
      area[0...gy].reverse.each_with_index do |row, i|
        return guard.fast_forward!(gx, gy - i) if row[gx] == @invalid_location
      end
    end

    if guard.direction == 'v'
      area[gy + 1..].each_with_index do |row, i|
        return guard.fast_forward!(gx, gy + i) if row[gx] == @invalid_location
      end
    end

    guard.leave_area!
  end

  # @param x [Integer]
  # @param y [Integer]
  private def mark_location_as_visited(x, y)
    @area[y][x] = @visited_location
  end
end

class Guard
  attr_accessor :direction, :x, :y

  def initialize(direction, x, y)
    @direction = direction
    @x = x
    @y = y
  end

  # @param x [Integer]
  # @param y [Integer]
  def fast_forward!(x, y)
    self.update!(@direction, x, y)
  end

  def leave_area!
    @x = -1
    @y = -1
  end

  def move!
    @x += { '^' => 0, '>' => 1, 'v' => 0, '<' => -1 }[@direction]
    @y += { '^' => -1, '>' => 0, 'v' => 1, '<' => 0 }[@direction]
  end

  def next_location
    { '^' => [@x, @y - 1], '>' => [@x + 1, @y], 'v' => [@x, @y + 1], '<' => [@x - 1, @y] }[@direction]
  end

  def rotate!
    @direction = { '^' => '>', '>' => 'v', 'v' => '<', '<' => '^' }[@direction]
  end

  def transpose!
    # This method is used to skip the first location
  end

  # @param direction [String]
  # @param x [Integer]
  # @param y [Integer]
  def update!(direction, x, y)
    @direction = direction
    @x = x
    @y = y
  end

  def to_s
    "x:#{@x},y:#{@y},direction:#{@direction}"
  end
end
