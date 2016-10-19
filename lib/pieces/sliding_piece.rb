class SlidingPiece < Piece

  UPDOWN = [
    [0, -1],
    [0, 1],
    [-1, 0],
    [1, 0]
  ]

  DIAGONAL = [
    [1, 1],
    [-1, -1],
    [1, -1],
    [-1, 1]
  ]

  def moves
    valid_moves = []
    move_dirs.each do |move_dir|
      new_y = position[0]
      new_x = position[1]
      valid_moves.concat(valid_moves_in_direction(new_x, new_y, move_dir))
    end
    valid_moves
  end

  private

  def valid_moves_in_direction(new_x, new_y, move_dir)
    valid_moves = []
    while true
      new_y += move_dir[0]
      new_x += move_dir[1]
      if board.in_bounds?([new_y, new_x]) && board[new_y, new_x].is_a?(NullPiece)
        valid_moves << [new_y, new_x]
      elsif board.in_bounds?([new_y, new_x]) && board[new_y, new_x].color != color
        valid_moves << [new_y, new_x]
        break
      else
        break
      end
    end
    valid_moves
  end

end
