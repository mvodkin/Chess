require "./lib/display"
require "./lib/player"

class Game

  attr_reader :player1, :player2, :board, :current_player
  attr_accessor :display

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @player1 = HumanPlayer.new(:light_cyan, @display)
    @player2 = HumanPlayer.new(:light_magenta, @display)
    @current_player = @player1
  end

  def play
    system("clear")
    until board.checkmate?(:light_cyan) || board.checkmate?(:light_magenta)
      begin
        start_pos, end_pos = current_player.take_turn
        board.move(start_pos, end_pos)
      rescue InvalidMoveError => e
        display.message = e.message + "\nTry again"
        retry
      end
      switch_players!
    end
    puts "Checkmate! #{@current_player.color.to_s} wins!"
  end

  private

  def switch_players!
    current_player == player1 ? @current_player = player2 : @current_player = player1
  end

end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end
