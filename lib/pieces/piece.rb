class Piece

  attr_reader :color, :board
  attr_accessor :position

  def initialize(position, color, board)
    @position, @color, @board = position, color, board
  end

  def move_into_check?(new_position)
    duped_board = board.dup
    duped_board.move!(position, new_position)
    duped_board.in_check?(color)
  end

  def valid_moves
    moves.reject { |move| move_into_check?(move) }
  end

  def receive_board(board)
    @board = board
  end

  def to_symbol
    self.class.to_s.downcase.to_sym
  end

  def dup(dup_board)
    self.class.new(position, color, dup_board)
  end

end
