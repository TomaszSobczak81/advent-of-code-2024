# frozen_string_literal: true
require_relative 'day00'

class Day16 < Day00
  protected def compute_part_one_solution(version_identifier)
    @maze = self.input_data_as_grid(@@part_one_identifier, version_identifier)
    @deer = @maze.each_with_index.map { |row, y| row.each_with_index.map { |cell, x| [x, y] if cell == 'S' }.compact }.flatten(1).first
    @score = nil

    self.possible_moves(@deer, 'E', [@deer]).each do |x, y, f|
      self.process_queue([x, y], f, (('E' == f) ? 1 : 1001), [@deer] + [[x, y]])
    end

    @score.to_s
  end

  protected def compute_part_two_solution(version_identifier)
    super
  end

  private def process_queue(deer, face, score, visited, level = 0)
    puts "@score: #{@score}, visited: #{visited.length}, level: #{level}"
    return if @score && score >= @score

    if @maze[deer[1]][deer[0]] == 'E'
      @score = score if @score.nil? || score < @score
      puts "Finished: #{score}"
      return
    end

    self.possible_moves(deer, face, visited + [deer]).each do |x, y, f, s|
      next if @score && (score + s) >= @score
      self.process_queue([x, y], f, score + s, visited + [deer], level + 1)
    end
  end

  # @param deer [Array<Integer>]
  # @param face [String]
  # @param visited [Array<Array<Integer>>]
  # @return [Array<Array<Integer,Integer,String,Integer>>]
  def possible_moves(deer, face, visited)
    moves = []
    x, y = deer

    case face
    when 'N'
      moves << [x, y - 1, face, 1] if @maze[y - 1][x] != '#' && !visited.include?([x, y - 1])
      moves << [x - 1, y, 'W', 1001] if @maze[y][x - 1] != '#' && !visited.include?([x - 1, y])
      moves << [x + 1, y, 'E', 1001] if @maze[y][x + 1] != '#' && !visited.include?([x + 1, y])
    when 'E'
      moves << [x + 1, y, face, 1] if @maze[y][x + 1] != '#' && !visited.include?([x + 1, y])
      moves << [x, y - 1, 'N', 1001] if @maze[y - 1][x] != '#' && !visited.include?([x, y - 1])
      moves << [x, y + 1, 'S', 1001] if @maze[y + 1][x] != '#' && !visited.include?([x, y + 1])
    when 'S'
      moves << [x, y + 1, face, 1] if @maze[y + 1][x] != '#' && !visited.include?([x, y + 1])
      moves << [x + 1, y, 'E', 1001] if @maze[y][x + 1] != '#' && !visited.include?([x + 1, y])
      moves << [x - 1, y, 'W', 1001] if @maze[y][x - 1] != '#' && !visited.include?([x - 1, y])
    when 'W'
      moves << [x - 1, y, face, 1] if @maze[y][x - 1] != '#' && !visited.include?([x - 1, y])
      moves << [x, y + 1, 'S', 1001] if @maze[y + 1][x] != '#' && !visited.include?([x, y + 1])
      moves << [x, y - 1, 'N', 1001] if @maze[y - 1][x] != '#' && !visited.include?([x, y - 1])
    end

    moves
  end
end
