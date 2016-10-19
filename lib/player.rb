require 'colorize'

InvalidMoveError = Class.new(StandardError)

class HumanPlayer

  attr_reader :color, :display

  def initialize(color, display)
    @color = color
    @display = display
  end

  def take_turn
    start_pos = display.get_cursor_input
    if display.board[*start_pos].is_a?(NullPiece)
      raise InvalidMoveError.new("There is no piece there")
    elsif display.board[*start_pos].color != color
      raise InvalidMoveError.new("It is not your turn!")
    end
    end_pos = display.get_cursor_input
    [start_pos, end_pos]
  end

end
