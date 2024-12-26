# frozen_string_literal: true
require_relative 'day00'

class Day17 < Day00
  protected def compute_part_one_solution(version_identifier)
    program, registers = self.load_input(@@part_one_identifier, version_identifier)
    computer = ChronospatialComputer.new(program, registers)
    computer.run
  end

  protected def compute_part_two_solution(version_identifier)
    program, registers = self.load_input(@@part_two_identifier, version_identifier)
    program_as_string = program.join(',')
    counter = program.reverse.join.gsub(/(0*)(\d+)/, '\2\1').to_i(8)
    counter = counter - counter % 8

    while counter
      computer = ChronospatialComputer.new(program, registers.merge({ :a => counter }))
      break if computer.run == program_as_string
      counter += 1
    end

    counter.to_s
  end

  private def load_input(part_identifier, version_identifier)
    program = []
    registers = {}

    self.input_data_as_lines(part_identifier, version_identifier).each do |line|
      next if line.empty?

      part, data = line.split(':')

      case part.downcase
      when 'register a'
        registers[:a] = data.to_i
      when 'register b'
        registers[:b] = data.to_i
      when 'register c'
        registers[:c] = data.to_i
      when 'program'
        program = data.split(',').map(&:to_i)
      else
        raise "Invalid part: #{part}"
      end
    end

    [program, registers]
  end
end

class ChronospatialComputer
  def initialize(program, registers = { :a => 0, :b => 0, :c => 0 })
    @output = []
    @pointer = 0
    @program = program
    @registers = registers
  end

  def run
    while @pointer < @program.length
      opcode = @program[@pointer]
      operand = @program[@pointer + 1]

      self.step(opcode, operand)
      @pointer += 2 unless opcode == 3 && @registers[:a] != 0
    end

    @output.join(',')
  end

  private def step(opcode, operand)
    case opcode
    when 0
      self.adv(operand)
    when 1
      self.bxl(operand)
    when 2
      self.bst(operand)
    when 3
      if @registers[:a] != 0
        self.jnz(operand)
      end
    when 4
      self.bxc(operand)
    when 5
      self.out(operand)
    when 6
      self.bdv(operand)
    when 7
      self.cdv(operand)
    else
      raise "Invalid opcode: #{opcode}"
    end
  end

  # @param operand [Integer]
  # @return [Integer]
  private def cmb(operand)
    case operand
    when 0, 1, 2, 3
      operand
    when 4
      @registers[:a]
    when 5
      @registers[:b]
    when 6
      @registers[:c]
    else
      raise "Invalid operand: #{operand}"
    end
  end

  private def adv(operand)
    @registers[:a] = (@registers[:a] / 2.pow(self.cmb(operand))).to_i
  end

  private def bxl(operand)
    @registers[:b] = @registers[:b] ^ operand
  end

  private def bst(operand)
    @registers[:b] = self.cmb(operand) % 8
  end

  private def jnz(operand)
    @pointer = operand
  end

  private def bxc(operand = nil)
    @registers[:b] = @registers[:b] ^ @registers[:c]
  end

  private def out(operand)
    @output << self.cmb(operand) % 8
  end

  private def bdv(operand)
    @registers[:b] = (@registers[:a] / 2.pow(self.cmb(operand))).to_i
  end

  private def cdv(operand)
    @registers[:c] = (@registers[:a] / 2.pow(self.cmb(operand))).to_i
  end
end
