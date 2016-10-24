require_relative 'cursor'
require_relative 'board'
require 'colorize'

class Display

  PIECES = {
    king: " \u265A ",
    queen: " \u265B ",
    rook: " \u265C ",
    bishop: " \u265D ",
    pawn: " \u265F ",
    nullpiece: "   ",
    knight: " \u265E "
  }
  attr_reader :board, :selected_piece, :cursor
  attr_accessor :message

  def initialize(board)
    @selected_piece = nil
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  def get_cursor_input
    pos = nil

    until pos
      render
      pos = cursor.get_input
      system("clear")
    end

    deselect_piece!(pos.dup)
    pos.dup
  end

  private

  def deselect_piece!(pos)
    selected_piece ? @selected_piece = nil : @selected_piece = pos
  end

  def render
    (0..7).each do |y|
      (0..7).each do |x|
        colorize_piece(x, y)
      end
      puts
    end
    puts message
    @message = nil
  end

  def colorize_piece(x, y)
    piece = board[y, x]
    display_piece = PIECES[piece.to_symbol]
    if [y, x] == selected_piece
      print display_piece.colorize(background:  :light_blue, :color => piece.color)
    elsif [y, x] == cursor.cursor_pos
      print display_piece.colorize(background: :green, :color => piece.color)
    elsif (y + x).even?
      print display_piece.colorize(background: :light_white, :color => piece.color)
    else
      print display_piece.colorize(background: :black, :color => piece.color)
    end
  end

end
