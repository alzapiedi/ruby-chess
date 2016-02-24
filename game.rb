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
 
  def choose_piece
    start = nil
    until start
      @display.render
      start = @display.get_input
    end
    if @board[start].nil?
      raise EmptySpaceError if @board[start].nil?
    elsif @board[start].color != @turn
      raise OtherColorError if @board[start].color != @turn
    else
      @board.current_piece = @board[start]
      start
    end
  end

  def choose_move(start)
    end_pos = nil
    until end_pos
      @display.render
      end_pos = @display.get_input
    end
    @board.current_piece = nil
    raise IllegalMoveError unless @board[start].moves.include?(end_pos)
    raise InCheckError if @board[start].move_into_check?(end_pos)
    end_pos
  end

  def play_turn
    start = choose_piece
    end_pos = choose_move(start)
    @board.move(start, end_pos)
    rescue EmptySpaceError => err
      puts err.message
      sleep(1)
      retry
    rescue OtherColorError => err
      puts err.message
      sleep(1)
      retry
    rescue IllegalMoveError => err
      puts err.message
      sleep(1)
      retry
    rescue InCheckError => err
      puts err.message
      sleep(1)
      retry
    @display.render
  end

  def play
    until @board.checkmate?(@turn)
      play_turn
      toggle_color
    end
    toggle_color
    @display.render
    puts "Checkmate! #{@turn.to_s.capitalize} wins"
  end

  def toggle_color
    @turn = (@turn == :white ? :black : :white)
  end
end

if __FILE__ == $PROGRAM_NAME

  a = Game.new
  a.play
end
