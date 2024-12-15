# frozen_string_literal: true

require 'thor'

class Aoc < Thor
  desc "day00", "Day 0 solutions solver to check if everything is working"

  def day00
    require_relative 'aoc/day00'
    Day00.new(123.to_s, 123.to_s.reverse).solve
  end

  desc "day01", "Day 1 solutions solver"

  def day01
    require_relative 'aoc/day01'
    Day01.new(11.to_s, 31.to_s).solve
  end

  desc "day02", "Day 2 solutions solver"

  def day02
    require_relative 'aoc/day02'
    Day02.new(2.to_s, 4.to_s).solve
  end

  desc "day03", "Day 3 solutions solver"

  def day03
    require_relative 'aoc/day03'
    Day03.new(161.to_s, 48.to_s).solve
  end

  desc "day04", "Day 4 solutions solver"

  def day04
    require_relative 'aoc/day04'
    Day04.new(18.to_s, 9.to_s).solve
  end

  desc "day05", "Day 5 solutions solver"

  def day05
    require_relative 'aoc/day05'
    Day05.new(143.to_s, 123.to_s).solve
  end

  desc "day06", "Day 6 solutions solver"

  def day06
    require_relative 'aoc/day06'
    Day06.new(41.to_s, 6.to_s.reverse).solve
  end

  desc "day07", "Day 7 solutions solver"

  def day07
    require_relative 'aoc/day07'
    Day07.new(3749.to_s, 11387.to_s).solve
  end

  desc "day08", "Day 8 solutions solver"

  def day08
    require_relative 'aoc/day08'
    Day08.new(14.to_s, 34.to_s).solve
  end

  desc "day09", "Day 9 solutions solver"

  def day09
    require_relative 'aoc/day09'
    Day09.new(1928.to_s, 2858.to_s).solve
  end

  desc "day10", "Day 10 solutions solver"

  def day10
    require_relative 'aoc/day10'
    Day10.new(36.to_s, 81.to_s).solve
  end

  desc "day11", "Day 11 solutions solver"

  def day11
    require_relative 'aoc/day11'
    Day11.new(55312.to_s, 65601038650482.to_s).solve
  end

  desc "day12", "Day 12 solutions solver"

  def day12
    require_relative 'aoc/day12'
    Day12.new(1930.to_s, 1206.to_s).solve
  end

  desc "day13", "Day 13 solutions solver"

  def day13
    require_relative 'aoc/day13'
    Day13.new(480.to_s, 1545093008502.to_s).solve
  end
end

Aoc.start(ARGV)
