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

    @possible_loops_positions = []
    @visited_positions = []

    while true
      break unless self.is_location_inside_area?(*(goto = guard.next_location))
      @visited_positions << guard.to_s

      if self.is_location_accessible?(*goto)
        shadow = guard.dup
        shadow.rotate!

        tmp = [shadow.to_s]
        while true
          break unless self.is_location_inside_area?(*(shadow_goto = shadow.next_location))
          self.is_location_accessible?(*shadow_goto) ? shadow.move! : shadow.rotate!
          tmp << shadow.to_s

          if (@visited_positions & tmp).size > 0
            @possible_loops_positions << goto
            break
          end
        end
      end

      self.is_location_accessible?(*goto) ? guard.move! : guard.rotate!
    end

    @possible_loops_positions
  end

  # @param x [Integer]
  # @param y [Integer]
  # @return [Boolean]
  def is_location_accessible?(x, y)
    @area[y][x] != @invalid_location
  end

  # @param x [Integer]
  # @param y [Integer]
  # @return [Boolean]
  def is_location_inside_area?(x, y)
    x.between?(0, @area[0].size - 1) && y.between?(0, @area.size - 1)
  end

  # @return [Guard]
  def locate_guard_position
    y = @area.find_index { |row| row.include?('^') }
    x = @area[y].find_index('^')

    Guard.new(@area[y][x], x, y)
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

  def move!
    case @direction
    when '^' then @y -= 1
    when '>' then @x += 1
    when 'v' then @y += 1
    when '<' then @x -= 1
    else raise "Invalid direction: #{@direction}"
    end
  end

  def next_location
    case @direction
    when '^' then [@x, @y - 1]
    when '>' then [@x + 1, @y]
    when 'v' then [@x, @y + 1]
    when '<' then [@x - 1, @y]
    else raise "Invalid direction: #{@direction}"
    end
  end

  def rotate!
    case @direction
    when '^' then @direction = '>'
    when '>' then @direction = 'v'
    when 'v' then @direction = '<'
    when '<' then @direction = '^'
    else raise "Invalid direction: #{@direction}"
    end
  end

  def to_s
    "x:#{@x},y:#{@y},direction:#{@direction}"
  end
end
