require "colorize"
require_relative "cursorable"

class Display
  include Cursorable

  def initialize(board)
    @board = board
    @cursor_pos = [6, 4]
  end
 
  def build_grid
    @board.grid.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      if piece.nil?
        "   ".colorize(color_options)
      else
        piece.to_s.colorize(color_options)
      end
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif !@board.current_piece.nil? && @board.current_piece.moves.include?([i, j]) && !@board.current_piece.move_into_check?([i, j])
      bg = ((i + j).odd?) ? :green : :light_green
    elsif (i + j).odd?
      bg = :black
    else
      bg = :white
    end
    { background: bg, color: @board[[i, j]].nil? ? :black : @board[[i, j]].color_option }
  end

  def render
    system("clear")
    puts "Arrow keys to move, space to confirm selection."
    build_grid.each { |row| puts row.join }
  end
end
