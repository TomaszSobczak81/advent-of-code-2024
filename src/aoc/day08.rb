# frozen_string_literal: true
require 'matrix'
require_relative 'day00'

class Day08 < Day00
  # @param version_identifier [String]
  # @param include_resonance [Boolean]
  # @return [String]
  protected def compute_part_one_solution(version_identifier, include_resonance = false)
    grid = self.input_data_as_grid(@@part_one_identifier, version_identifier)
    sets = self.parse_grid_into_signal_sets(grid)

    self.extract_antinodes_from_signal_sets(sets, grid, include_resonance).size.to_s
  end

  # @param version_identifier [String]
  # @return [String]
  protected def compute_part_two_solution(version_identifier)
    self.compute_part_one_solution(version_identifier, true)
  end

  # @param grid [Array<Array<String>>]
  # @return [Hash<String=>Set<Array<Integer>>]
  private def parse_grid_into_signal_sets(grid)
    sets = {}

    grid.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        sets[cell].nil? ? sets[cell] = Set.new([[x, y]]) : sets[cell].add([x, y]) if cell != '.'
      end
    end

    sets
  end

  # @param sets [Hash<String=>Set<Array<Integer>>]
  # @param grid [Array<Array<String>>]
  # @param include_resonance [Boolean]
  # @return [Set<Array<Integer>>]
  private def extract_antinodes_from_signal_sets(sets, grid, include_resonance = false)
    antinodes = Set.new

    sets.each do |s, points|
      points.to_a.combination(2).each do |a, b|
        va = Vector[a[0], a[1]]
        vb = Vector[b[0], b[1]]
        vc = vb - va

        if include_resonance
          while (va = va + vc)[1].between?(0, grid.size - 1) && va[0].between?(0, grid[0].size - 1)
            antinodes.add(va)
          end

          while (vb = vb - vc)[1].between?(0, grid.size - 1) && vb[0].between?(0, grid[0].size - 1)
            antinodes.add(vb)
          end
        else
          a1 = va - vc
          a2 = vb + vc

          antinodes.add(a1) if a1[1].between?(0, grid.size - 1) && a1[0].between?(0, grid[0].size - 1)
          antinodes.add(a2) if a2[1].between?(0, grid.size - 1) && a2[0].between?(0, grid[0].size - 1)
        end
      end
    end

    antinodes
  end
end
