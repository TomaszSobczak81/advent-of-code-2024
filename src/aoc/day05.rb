# frozen_string_literal: true
require_relative 'day00'

class Day05 < Day00
  # @param version_identifier [String]
  # @return [String
  protected def compute_part_one_solution(version_identifier)
    rules, queues = self.erratum_data(version_identifier)

    queues.map do |q|
      q.join == self.sort_print_queue(rules, q).join ? q[q.size / 2] : 0
    end.sum.to_s
  end

  # @param version_identifier [String]
  # @return [String]
  protected def compute_part_two_solution(version_identifier)
    rules, queues = self.erratum_data(version_identifier)

    queues.map do |q|
      q.join == (sorted = self.sort_print_queue(rules, q)).join ? 0 : sorted[q.size / 2]
    end.sum.to_s
  end

  # @param version_identifier [String]
  # @return [[Hash<Integer=>Array<Integer>>, Array<Integer>]]
  private def erratum_data(version_identifier)
    print_rules = {}
    page_queues = []

    self.input_data_as_lines(@@part_one_identifier, version_identifier).each do |line|
      if line.include?('|')
        a, b = line.split('|').map { |i| i.to_i }
        print_rules.key?(a) ? print_rules[a] << b : print_rules[a] = [b]
      else
        page_queues << line.split(',').map { |i| i.to_i }
      end
    end

    [print_rules, page_queues.reject { |e| e.empty? }]
  end

  # @param rules [Hash<Integer=>Array<Integer>>]
  # @param q [Array<Integer>]
  # @return [Array<Integer>]
  private def sort_print_queue(rules, q)
    q.each do |v|
      rules.fetch(v, []).each do |j|
        q.insert(q.find_index(j), q.delete_at(q.find_index(v))) if q.include?(j) && q.find_index(j) < q.find_index(v)
      end
    end
  end
end
