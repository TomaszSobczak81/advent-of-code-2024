# frozen_string_literal: true
require_relative 'day00'

class Day02 < Day00
  # @param version_identifier [String]
  # @return [String]
  protected def compute_part_one_solution(version_identifier)
    self.load_reports(@@part_one_identifier, version_identifier).map do |report|
      self.is_report_valid(report)
    end.select { |i| i }.count.to_s
  end

  # @param version_identifier [String]
  # @return [String]
  protected def compute_part_two_solution(version_identifier)
    self.load_reports(@@part_one_identifier, version_identifier).map do |report|
      report_copy = report.dup
      report_loop = 0
      report_size = report.size

      until self.is_report_valid(report_copy) do
        report_copy, report_loop = self.remove_level_from_report(report, report_loop)
        break if report_loop >= report_size
      end

      self.is_report_valid(report_copy)
    end.select { |i| i }.count.to_s
  end

  # @param report [Array<Integer>]
  # @param report_loop [Integer]
  # @return [[Array<Integer>, Integer]]
  private def remove_level_from_report(report, report_loop)
    report_copy = report.dup
    report_copy.delete_at(report_loop)
    [report_copy, report_loop + 1]
  end

  # @param report [Array<Integer>]
  # @return [Boolean]
  def is_report_valid(report)
    trend = report[0] != report[1] && report[0] <=> report[1]
    report.each_cons(2).map do |a, b|
      (0...4) === (a - b).abs && trend == (a <=> b)
    end.all?
  end

  # @param part_identifier [String]
  # @param version_identifier [String]
  # @return [[<Array<Integer>]]
  private def load_reports(part_identifier, version_identifier)
    reports = []

    self.input_data_as_lines(part_identifier, version_identifier).each do |line|
      reports << line.split.map { |x| x.to_i }
    end

    reports
  end
end
