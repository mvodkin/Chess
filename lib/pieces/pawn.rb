class Pawn < SteppingPiece

  def move_dirs
    color == :light_cyan ? light_cyan_dirs : light_magenta_dirs
  end

  def light_cyan_dirs
    potential_moves = []
    if board[position[0] - 1, position[1]].is_a?(NullPiece)
      potential_moves << [-1, 0]
      if position[0] == 6 && board[position[0] - 2, position[1]].is_a?(NullPiece)
        potential_moves << [-2, 0]
      end
    end

    diagonal_diffentials = [[-1, -1], [-1, 1]]
    potential_moves.concat(diagonal_dirs(diagonal_diffentials))

    potential_moves
  end

  def diagonal_dirs(differentials)

    diagonal_moves = []
    differentials.each do |differential|
      new_y = position[0] + differential[0]
      new_x = position[1] + differential[1]

      if (!board[new_y, new_x].is_a?(NullPiece) &&
          new_y.between?(0, 7) && new_x.between?(0, 7) &&
          board[new_y, new_x].color != color)
        diagonal_moves << differential
      end
    end

    diagonal_moves
  end

  def light_magenta_dirs
    potential_moves = []
    if board[position[0] + 1, position[1]].is_a?(NullPiece)
      potential_moves << [1, 0]
      if position[0] == 1 && board[position[0] + 2, position[1]].is_a?(NullPiece)
        potential_moves << [2, 0]
      end
    end

    diagonal_diffentials = [[1, 1], [1, -1]]
    potential_moves.concat(diagonal_dirs(diagonal_diffentials))

    potential_moves
  end

end
