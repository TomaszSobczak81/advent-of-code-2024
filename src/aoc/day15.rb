# frozen_string_literal: true
require_relative 'day00'

class Day15 < Day00
  protected def compute_part_one_solution(version_identifier)
    @cell_box_marker = 'O'
    @cell_empty_marker = '.'
    @cell_robot_marker = '@'
    @cell_wall_marker = '#'

    @grid, moves = self.initialize_data(version_identifier)
    @curr = @grid.each_with_index.map { |row, y| row.each_with_index.map { |cell, x| [x, y] if cell == @cell_robot_marker }.compact }.flatten(1).first

    moves.each { |m| self.move_robot!(m) }
    gps = 0

    @grid.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        gps += (y * 100).to_i + x if cell == @cell_box_marker
      end
    end

    gps.to_s
  end

  protected def compute_part_two_solution(version_identifier)
    @cell_lbox_marker = '['
    @cell_rbox_marker = ']'
    @cell_wbox_marker = [@cell_lbox_marker, @cell_rbox_marker]

    transitions = {
      @cell_box_marker => @cell_wbox_marker,
      @cell_empty_marker => %w(. .),
      @cell_robot_marker => %w(@ .),
      @cell_wall_marker => %w(# #)
    }

    grid, moves = self.initialize_data(version_identifier)
    @grid = grid.map { |row| row.map { |cell| transitions[cell] }.flatten }
    @curr = @grid.each_with_index.map { |row, y| row.each_with_index.map { |cell, x| [x, y] if cell == @cell_robot_marker }.compact }.flatten(1).first

    moves.each { |m| self.move_robot_over_wide_grid!(m) }
    gps = 0

    @grid.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        gps += (y * 100).to_i + x if cell == @cell_lbox_marker
      end
    end

    gps.to_s
  end

  # @param version_identifier [String]
  # @return [[Array<Array<String>>, Array<String>]]
  private def initialize_data(version_identifier)
    lines = self.input_data_as_lines(@@part_one_identifier, version_identifier)

    [
      lines.select { |l| l.start_with?(@cell_wall_marker) }.map { |a| a.split('') },
      lines.select { |l| l.start_with?('<', '^', 'v', '>') }.join.split('')
    ]
  end

  private def get_next_location(curr, move)
    x, y = curr

    x += 1 if move == '>'
    x -= 1 if move == '<'
    y += 1 if move == 'v'
    y -= 1 if move == '^'

    [x, y]
  end

  private def move_robot!(move)
    _next = self.get_next_location(@curr, move)
    return if @grid[_next[1]][_next[0]] == @cell_wall_marker

    self.push_boxes_to_empty_location!(_next, move) if @grid[_next[1]][_next[0]] == @cell_box_marker
    self.move_robot_to_empty_location!(_next) if @grid[_next[1]][_next[0]] == @cell_empty_marker
  end

  private def move_robot_over_wide_grid!(move)
    _next = self.get_next_location(@curr, move)
    return if @grid[_next[1]][_next[0]] == @cell_wall_marker


    _next_is_wbox = @cell_wbox_marker.include?(@grid[_next[1]][_next[0]])

    self.push_x_wide_boxes_to_empty_location!(_next, move) if %w(< >).include?(move) && _next_is_wbox
    self.push_y_wide_boxes_to_empty_location!(_next, move) if %w(^ v).include?(move) && _next_is_wbox
    self.move_robot_to_empty_location!(_next) if @grid[_next[1]][_next[0]] == @cell_empty_marker
  end

  private def move_robot_to_empty_location!(location)
    raise 'Invalid move' if @grid[location[1]][location[0]] != @cell_empty_marker

    @grid[@curr[1]][@curr[0]] = @cell_empty_marker
    @grid[location[1]][location[0]] = @cell_robot_marker
    @curr = location
  end

  private def push_boxes_to_empty_location!(location, move)
    _next = self.get_next_location(location, move)
    return if @grid[_next[1]][_next[0]] == @cell_wall_marker

    self.push_boxes_to_empty_location!(_next, move) if @grid[_next[1]][_next[0]] == @cell_box_marker
    return if @grid[_next[1]][_next[0]] != @cell_empty_marker

    @grid[location[1]][location[0]] = @cell_empty_marker
    @grid[_next[1]][_next[0]] = @cell_box_marker
  end

  private def push_x_wide_boxes_to_empty_location!(location, move)
    _next = self.get_next_location(location, move)
    return if @grid[_next[1]][_next[0]] == @cell_wall_marker

    self.push_x_wide_boxes_to_empty_location!(_next, move) if @cell_wbox_marker.include?(@grid[_next[1]][_next[0]])
    return if @grid[_next[1]][_next[0]] != @cell_empty_marker

    @grid[_next[1]][_next[0]] = @grid[location[1]][location[0]]
    @grid[location[1]][location[0]] = @cell_empty_marker
  end

  private def push_y_wide_boxes_to_empty_location!(location, move)
    _curr_a = @grid[location[1]][location[0]]
    _side_l = _curr_a == @cell_rbox_marker ? [location[0] - 1, location[1]] : [location[0] + 1, location[1]]
    _curr_b = @grid[_side_l[1]][_side_l[0]]
    _next_a = self.get_next_location(location, move)
    _next_b = self.get_next_location(_side_l, move)
    return if [@grid[_next_a[1]][_next_a[0]], @grid[_next_b[1]][_next_b[0]]].any?(@cell_wall_marker)

    _next_a_is_wbox = @cell_wbox_marker.any?(@grid[_next_a[1]][_next_a[0]])
    _next_b_is_wbox = @cell_wbox_marker.any?(@grid[_next_b[1]][_next_b[0]])

    if _curr_a == @grid[_next_b[1]][_next_b[0]] && _curr_b == @grid[_next_a[1]][_next_a[0]]
      self.push_y_wide_boxes_to_empty_location!(_next_a, move)
      self.push_y_wide_boxes_to_empty_location!(_next_b, move)
    end

    if _curr_a == @grid[_next_b[1]][_next_b[0]] && @cell_empty_marker == @grid[_next_a[1]][_next_a[0]]
      self.push_y_wide_boxes_to_empty_location!(_next_b, move)
    elsif _curr_b == @grid[_next_a[1]][_next_a[0]] && @cell_empty_marker == @grid[_next_b[1]][_next_b[0]]
      self.push_y_wide_boxes_to_empty_location!(_next_a, move)
    end

    if _curr_a == @grid[_next_a[1]][_next_a[0]]
      self.push_y_wide_boxes_to_empty_location!(_next_a, move)
    elsif _curr_b == @grid[_next_b[1]][_next_b[0]]
      self.push_y_wide_boxes_to_empty_location!(_next_b, move)
    end
    return unless [@grid[_next_a[1]][_next_a[0]], @grid[_next_b[1]][_next_b[0]]].all?(@cell_empty_marker)

    @grid[_next_a[1]][_next_a[0]] = _curr_a
    @grid[_next_b[1]][_next_b[0]] = _curr_b
    @grid[location[1]][location[0]] = @cell_empty_marker
    @grid[_side_l[1]][_side_l[0]] = @cell_empty_marker
  end
end
