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

  desc "day14", "Day 14 solutions solver"

  def day14
    require_relative 'aoc/day14'
    Day14.new(21.to_s, 1.to_s).solve
  end

  desc "day15", "Day 15 solutions solver"

  def day15
    require_relative 'aoc/day15'
    Day15.new(10092.to_s, 9021.to_s).solve
  end

  desc "day16", "Day 16 solutions solver"

  def day16
    require_relative 'aoc/day16'
    Day16.new(7036.to_s, 597.to_s).solve
  end

  desc "day17", "Day 17 solutions solver"

  def day17
    require_relative 'aoc/day17'
    Day17.new("4,6,3,5,6,3,5,2,1,0", 117440.to_s).solve
  end

  desc "day18", "Day 18 solutions solver"

  def day18
    require_relative 'aoc/day18'
    Day18.new(22.to_s, '6,1').solve
  end
end

Aoc.start(ARGV)
