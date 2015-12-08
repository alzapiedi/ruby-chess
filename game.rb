require_relative "board"
require_relative "display"
require 'byebug'

class Game
  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @board.populate
    @turn = :white
  end

  def play_turn
    begin
      start = nil
      until start
        @display.render
        start = @display.get_input
      end
      raise EmptySpaceError if @board[start].nil?
      raise OtherColorError if @board[start].color != @turn
    rescue EmptySpaceError => err
      puts err.message
      sleep(1)
      retry
    rescue OtherColorError => err
      puts err.message
      sleep(1)
      retry
    end
    begin
      end_pos = nil
      until end_pos
        @display.render
        end_pos = @display.get_input
      end
      raise IllegalMoveError unless @board[start].moves.include?(end_pos)
    rescue IllegalMoveError => err
      puts err.message
      sleep(1)
      retry
    end

    @board.move(start,end_pos)
    @display.render
  end

  def play
    until @board.checkmate?(@turn)
      play_turn
      toggle_color
    end
  end

  def toggle_color
    @turn = (@turn == :white ? :black : :white)
  end
end





if __FILE__ == $PROGRAM_NAME

  a = Game.new
  a.play
end
