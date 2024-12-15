# frozen_string_literal: true
require_relative 'day00'

class Day13 < Day00
  # @param version_identifier [String]
  # @return [String]
  protected def compute_part_one_solution(version_identifier, prize_override = nil)
    self.input_data_as_lines(@@part_one_identifier, version_identifier).each_slice(4).map do |slice|
      a_x, a_y = slice[0].split(',').map { |x| x.scan(/\d/).join.to_i }
      b_x, b_y = slice[1].split(',').map { |x| x.scan(/\d/).join.to_i }
      p_x, p_y = slice[2].split(',').map { |x| x.scan(/\d/).join.to_i }

      a_xs = (1..100).map { |x| x * a_x }
      a_ys = (1..100).map { |y| y * a_y }
      b_xs = (1..100).map { |x| x * b_x }
      b_ys = (1..100).map { |y| y * b_y }

      x_sums = a_xs.product(b_xs).map { |x| [x, x.sum] }
      y_sums = a_ys.product(b_ys).map { |y| [y, y.sum] }

      x_clicks = x_sums.select { |x| x[1] == p_x }.map { |x| [x[0][0] / a_x, x[0][1] / b_x] }
      y_clicks = y_sums.select { |y| y[1] == p_y }.map { |y| [y[0][0] / a_y, y[0][1] / b_y] }

      xy_clicks = x_clicks & y_clicks
      xy_clicks[0][0] * 3 + xy_clicks[0][1] * 1 if xy_clicks.any?
    end.compact.sum.to_s
  end

  # @param version_identifier [String]
  # @return [String]
  protected def compute_part_two_solution(version_identifier)
    # self.compute_part_one_solution(version_identifier, 10_000_000_000_000)
    super
  end
end
