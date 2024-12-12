# frozen_string_literal: true
require_relative 'day00'

class Day12 < Day00
  # @param version_identifier [String]
  # @return [String]
  protected def compute_part_one_solution(version_identifier)
    @garden = self.input_data_as_grid(@@part_one_identifier, version_identifier)
    @plants = @garden.flatten.uniq
    @regions = {}

    @garden.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        self.extract_region!(y, x, cell)
      end
    end

    @regions.values.map { |r| r.size * self.calculate_perimeter_length(r) }.sum.to_s
  end

  # @param version_identifier [String]
  # @return [String]
  protected def compute_part_two_solution(version_identifier)
    @garden = self.input_data_as_grid(@@part_one_identifier, version_identifier)
    @plants = @garden.flatten.uniq
    @regions = {}

    @garden.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        self.extract_region!(y, x, cell)
      end
    end

    @regions.values.map { |r| r.size * self.calculate_perimeter_segments(r) }.sum.to_s
  end

  # @param y [Integer]
  # @param x [Integer]
  # @param plant [String]
  # @param origin [String]
  # @return [void]
  private def extract_region!(y, x, plant, origin = nil)
    return if y < 0 || y >= @garden.length || x < 0 || x >= @garden[0].length || @garden[y][x] != plant || !@plants.include?(plant)
    origin = "#{y}-#{x}" if origin.nil?
    pointer = "#{plant}-#{origin}"
    @regions["#{plant}-#{origin}"] = Set.new if @regions[pointer].nil?
    @regions[pointer].add([y, x])
    @garden[y][x] = nil

    [[y - 1, x], [y + 1, x], [y, x - 1], [y, x + 1]].each do |(y2, x2)|
      self.extract_region!(y2, x2, plant, origin)
    end
  end

  # @param region [Set<Array<Integer>>]
  # @return [Integer]
  private def calculate_perimeter_length(region)
    perimeter = 0

    region.each do |(y, x)|
      [[y - 1, x], [y + 1, x], [y, x - 1], [y, x + 1]].each do |position|
        perimeter += 1 unless region.include?(position)
      end
    end

    perimeter
  end

  # @param region [Set<Array<Integer>>]
  # @return [Integer]
  private def calculate_perimeter_segments(region)
    edges = Set.new
    perimeter = Set.new

    region.each do |(y, x)|
      unless region.include?([y - 1, x]) # North
        edges.add({ :s => [y, x], :e => [y, x + 1] })
        perimeter.add([y, x])
        perimeter.add([y, x + 1])
      end

      unless region.include?([y, x + 1]) # East
        edges.add({ :s => [y, x + 1], :e => [y + 1, x + 1] })
        perimeter.add([y, x + 1])
        perimeter.add([y + 1, x + 1])
      end

      unless region.include?([y + 1, x]) # South
        edges.add({ :s => [y + 1, x + 1], :e => [y + 1, x] })
        perimeter.add([y + 1, x])
        perimeter.add([y + 1, x + 1])
      end

      unless region.include?([y, x - 1]) # West
        edges.add({ :s => [y + 1, x], :e => [y, x] })
        perimeter.add([y, x])
        perimeter.add([y + 1, x])
      end
    end

    edges = edges.to_a
    point = perimeter.to_a.sort[0]

    prev_edge = nil
    segments = 1

    until edges.empty?
      next_edge_location = edges.index { |e| e[:s] == point }

      if next_edge_location.nil?
        next_edge_location = 0
        prev_edge = nil
        segments += 1
      end

      edge = edges.delete_at(next_edge_location)

      segments += 1 if prev_edge and self.edge_course(prev_edge) != self.edge_course(edge)

      prev_edge = edge
      point = prev_edge[:e]
    end

    segments
  end

  # @param edge [Hash]
  # @return [String]
  private def edge_course(edge)
    return 'E' if edge[:s][0] == edge[:e][0] && edge[:s][1] < edge[:e][1] # East
    return 'S' if edge[:s][1] == edge[:e][1] && edge[:s][0] < edge[:e][0] # South
    return 'W' if edge[:s][0] == edge[:e][0] && edge[:s][1] > edge[:e][1] # West
    return 'N' if edge[:s][1] == edge[:e][1] && edge[:s][0] > edge[:e][0] # North

    raise "Invalid edge: #{edge}"
  end
end
