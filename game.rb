require_relative "board"
require_relative "display"

class Game
  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @board.populate
    @turn = :white
  end

  def play_turn(color)
    start = nil
    end_pos = nil
    until start
        @display.render
        start = @display.get_input
    end
    until end_pos
      @display.render
      end_pos = @display.get_input
    end
    @board.move(start,end_pos)
    @display.render
  end

end





if __FILE__ == $PROGRAM_NAME

  Game.new.play_turn(:white)
end
