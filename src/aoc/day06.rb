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
    area.process_guard_movement!

    loops = Set.new

    area.path.each do |x, y|
      prev = area.update_location(x, y, '#')
      loops.add([x, y]) if area.check_if_loop_exists?
      area.update_location(x, y, prev)
    end

    loops.count.to_s
  end
end

class Area
  # @param area [Array<Array<String>>]
  # @return [Area]
  def initialize(area)
    @area = area
    @invalid_location = '#'
    @visited_location = 'X'

    @guard = self.locate_guard_position
  end

  # @return [Integer]
  def count_visited_locations
    self.process_guard_movement!
    @area.flatten.count(@visited_location)
  end

  # @return [Array<Array<Integer>>]
  def path
    @area.each_with_index.map do |row, y|
      row.each_with_index.map do |cell, x|
        [x, y] if cell == @visited_location
      end
    end.flatten(1).compact
  end

  def process_guard_movement!
    guard = self.locate_guard_position

    while true
      break if self.is_location_outside_area?(*(goto = guard.next_location))
      self.is_location_accessible?(*goto) ? guard.move! : guard.rotate!
      self.mark_location_as_visited(guard.x, guard.y)
    end
  end

  # @param x [Integer]
  # @param y [Integer]
  # @param value [String]
  # @return [String]
  def update_location(x, y, value)
    prev = @area[y][x]
    @area[y][x] = value
    prev
  end

  # @return [Boolean]
  def check_if_loop_exists?
    self.reset_guard_location!

    guard = self.locate_guard_position
    path = Set.new

    while true
      self.fast_forward_guard_to_next_obstacle!(guard)
      break if self.is_location_outside_area?(guard.x, guard.y)

      unless path.add?(guard.to_s)
        return true
      end

      guard.rotate!
    end

    false
  end

  # @param guard [Guard]
  private def fast_forward_guard_to_next_obstacle!(guard)
    gx, gy = guard.x, guard.y

    if guard.direction == '>'
      @area[gy][gx + 1..].each_with_index do |cell, i|
        return guard.fast_forward!(gx + i, gy) if cell == @invalid_location
      end
    end

    if guard.direction == '<'
      @area[gy][0...gx].reverse.each_with_index do |cell, i|
        return guard.fast_forward!(gx - i, gy) if cell == @invalid_location
      end
    end

    if guard.direction == '^'
      @area[0...gy].reverse.each_with_index do |row, i|
        return guard.fast_forward!(gx, gy - i) if row[gx] == @invalid_location
      end
    end

    if guard.direction == 'v'
      @area[gy + 1..].each_with_index do |row, i|
        return guard.fast_forward!(gx, gy + i) if row[gx] == @invalid_location
      end
    end

    guard.leave_area!
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
  private def is_location_outside_area?(x, y)
    x < 0 || y < 0 || x >= @area[0].size || y >= @area.size
  end

  # @return [Guard]
  private def locate_guard_position
    y = @area.find_index { |row| row.include?('^') }
    x = @area[y].find_index('^')

    Guard.new(@area[y][x], x, y)
  end

  # @param x [Integer]
  # @param y [Integer]
  private def mark_location_as_visited(x, y)
    @area[y][x] = @visited_location
  end

  private def reset_guard_location!
    self.update_location(@guard.x, @guard.y, @guard.direction)
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

  # @return [Array<Integer>]
  def next_location
    { '^' => [@x, @y - 1], '>' => [@x + 1, @y], 'v' => [@x, @y + 1], '<' => [@x - 1, @y] }[@direction]
  end

  # @return [String]
  def rotate!
    @direction = { '^' => '>', '>' => 'v', 'v' => '<', '<' => '^' }[@direction]
  end

  # @param direction [String]
  # @param x [Integer]
  # @param y [Integer]
  def update!(direction, x, y)
    @direction = direction
    @x = x
    @y = y
  end

  # @return [String]
  def to_s
    "x:#{@x},y:#{@y},direction:#{@direction}"
  end
end
