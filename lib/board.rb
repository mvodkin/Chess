require_relative "./pieces/all_pieces"

InvalidMoveError = Class.new(StandardError)

class Board

  attr_accessor :grid

  def initialize(grid = Array.new(8) { Array.new(8) { NullPiece.instance } })
    @grid = grid
    populate
  end

  def [](*pos)
    x, y = pos
    grid[x][y]
  end

  def []=(*pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def move(start_pos, end_pos)
    piece = self[*start_pos]
    if piece.move_into_check?(end_pos)
      raise InvalidMoveError.new("That move would put you in check")
    elsif !piece.valid_moves.include?(end_pos)
      raise InvalidMoveError.new("Invalid move")
    end
    self[*start_pos] = NullPiece.instance
    self[*end_pos] = piece
    piece.position = end_pos
  end

  def move!(start_pos, end_pos)
    piece = self[*start_pos]
    self[*start_pos] = NullPiece.instance
    self[*end_pos] = piece
    piece.position = end_pos
  end

  def dup
    dup_board = Board.new
    (0..7).each do |row|
      new_row = []
      (0..7).each do |col|
        piece = self[row, col]
        new_row << piece.dup(dup_board)
      end
      dup_board.grid[row] = new_row
    end

    dup_board

  end

  def checkmate?(color)
    player_pieces(color).each do |piece|
      return false unless piece.valid_moves.empty?
    end
    true
  end

  def in_bounds?(pos)
    pos.all? { |coordinate| coordinate.between?(0, 7) }
  end

  def in_check?(color)
    opposing_moves(color).include?(find_king(color))
  end

  private

  def populate
    populate_pawns
    populate_bishops
    populate_knights
    populate_rooks
    self[0, 3] = Queen.new([0, 3], :light_magenta, self)
    self[0, 4] = King.new([0, 4], :light_magenta, self)
    self[7, 3] = Queen.new([7, 3], :light_cyan, self)
    self[7, 4] = King.new([7, 4], :light_cyan, self)
  end

  def populate_pawns
    @grid[1].map!.with_index do |square, x|
      square = Pawn.new([1, x], :light_magenta, self)
    end
    @grid[6].map!.with_index do |square, x|
      square = Pawn.new([6, x], :light_cyan, self)
    end
  end

  def populate_bishops
    self[0, 2] = Bishop.new([0, 2], :light_magenta, self)
    self[0, 5] = Bishop.new([0, 5], :light_magenta, self)
    self[7, 5] = Bishop.new([7, 5], :light_cyan, self)
    self[7, 2] = Bishop.new([7, 2], :light_cyan, self)
  end

  def populate_knights
    self[0, 1] = Knight.new([0, 1], :light_magenta, self)
    self[0, 6] = Knight.new([0, 6], :light_magenta, self)
    self[7, 6] = Knight.new([7, 6], :light_cyan, self)
    self[7, 1] = Knight.new([7, 1], :light_cyan, self)
  end

  def populate_rooks
    self[0, 0] = Rook.new([0, 0], :light_magenta, self)
    self[0, 7] = Rook.new([0, 7], :light_magenta, self)
    self[7, 7] = Rook.new([7, 7], :light_cyan, self)
    self[7, 0] = Rook.new([7, 0], :light_cyan, self)
  end

  def player_pieces(color)
    result = []
    @grid.each do |row|
      result.concat(row.select do |square|
        square.is_a?(Piece) && square.color == color
      end)
    end
    result
  end

  def opposing_moves(color)

    opposing_pieces = @grid.map do |row|
      row.select do |square|
        square.is_a?(Piece) && square.color != color
      end
    end.flatten

    opposing_moves = []

    opposing_pieces.each { |piece| opposing_moves.concat(piece.moves) }

    opposing_moves

  end

  def find_king(color)
    king = nil
    @grid.each do |row|
      row.each do |square|
        if square.is_a?(King) && square.color == color
          king = square
        end
      end
    end
    king ? king.position : nil
  end

end
