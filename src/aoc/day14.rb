# frozen_string_literal: true
require 'matrix'
require_relative 'day00'

class Day14 < Day00
  protected def compute_part_one_solution(version_identifier)
    limits = { :x => 101, :y => 103 }
    result = Hash.new(0)

    self.initialize_robots(version_identifier, limits).each do |robot|
      robot.move!(100)
      result[robot.quadrant] += 1 if robot.quadrant
    end

    result.values.reduce(1) { |p, r| (p * r).to_i }.to_s
  end

  protected def compute_part_two_solution(version_identifier)
    limits = { :x => 101, :y => 103 }
    robots = self.initialize_robots(version_identifier, limits)
    rounds = 0

    while true
      rounds += 1
      robots.each { |r| r.move! }
      break if robots.map(&:location_as_a).uniq.count == robots.count
    end

    rounds.to_s
  end

  # @param version_identifier [String]
  # @param limits [Hash<Symbol, Integer>]
  # @return [Array<SafetyRobot>]
  private def initialize_robots(version_identifier, limits)
    robots = []

    self.input_data_as_lines(@@part_one_identifier, version_identifier).each do |line|
      if line =~ /p=([\d-]+),([\d-]+) v=([\d-]+),([\d-]+)/
        robots << SafetyRobot.new($1.to_i, $2.to_i, $3.to_i, $4.to_i, limits[:x], limits[:y])
      end
    end

    robots
  end
end

class SafetyRobot
  attr_reader :location

  # @param lx [Integer]
  # @param ly [Integer]
  # @param vx [Integer]
  # @param vy [Integer]
  # @param mx [Integer]
  # @param my [Integer]
  # @return [SafetyRobot]
  def initialize(lx, ly, vx, vy, mx, my)
    @location = Vector[lx, ly]
    @velocity = Vector[vx, vy]
    @lx_limit = mx
    @ly_limit = my
  end

  # @return [Array<Integer>]
  def location_as_a
    @location.to_a
  end

  # @param repeat [Integer]
  def move!(repeat = 1)
    repeat.times do
      @location += @velocity
      @location[0] %= @lx_limit
      @location[1] %= @ly_limit
    end
  end

  # @return [Integer]
  def quadrant
    case
    when @location[0] < @lx_limit / 2 && @location[1] < @ly_limit / 2
      return 1
    when @location[0] > @lx_limit / 2 && @location[1] < @ly_limit / 2
      return 2
    when @location[0] < @lx_limit / 2 && @location[1] > @ly_limit / 2
      return 3
    when @location[0] > @lx_limit / 2 && @location[1] > @ly_limit / 2
      return 4
    else
      return nil
    end
  end
end