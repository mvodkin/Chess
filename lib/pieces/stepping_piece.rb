class SteppingPiece < Piece

  KINGDIRS = [
    [0, -1],
    [0, 1],
    [-1, 0],
    [1, 0],
    [1, 1],
    [-1, -1],
    [1, -1],
    [-1, 1]
  ]

  KNIGHTDIRS = [
    [1, 2],
    [2, 1],
    [-1, -2],
    [-2, -1],
    [1, -2],
    [-2, 1],
    [2, -1],
    [-1, 2]
  ]

  def moves
    move_dirs.map do |change|
      new_y = position[0] + change[0]
      new_x = position[1] + change[1]
      [new_y, new_x]
    end.select do |pos|
      @board.in_bounds?(pos) &&
      (@board[*pos].is_a?(NullPiece) || @board[*pos].color != color)
    end
  end

end
