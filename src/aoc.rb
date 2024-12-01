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
end

Aoc.start(ARGV)
