require_relative 'sliding'
require_relative 'stepping'
require 'byebug'
class Piece
  attr_reader :color, :color_option, :board
  attr_accessor :pos
  CARDINALS = [[-1, 0], [1, 0], [0, -1], [0, 1]]
  DIAGONALS = [[-1, -1], [-1, 1], [1, 1], [1, -1]]
  def initialize(color, board, pos)
    @color = color
    @enemy_color = (@color == :white ? :black : :white)
    @board = board
    @pos = pos
    @board[@pos] = self
    @color_option = (@color == :white ? :green : :light_blue)
  end

  def inspect
    to_s
  end

  def move_into_check?(test_pos)
    test_board = @board.deep_dup
    test_board.move(@pos, test_pos)
    test_board.in_check?(color)
  end
end

class Knight < Piece
  include Stepping
  DELTAS = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]

  def to_s
    " ♞ "
  end

  def move_dirs
    DELTAS
  end
end

class King < Piece
  include Stepping

  def to_s
    " ♚ "
  end

  def move_dirs
    CARDINALS + DIAGONALS
  end
end

class Bishop < Piece
  include Sliding

  def move_dirs
    DIAGONALS
  end

  def to_s
    " ♝ "
  end
end

class Rook < Piece
  include Sliding

  def move_dirs
    CARDINALS
  end

  def to_s
    " ♜ "
  end
end

class Queen < Piece
  include Sliding

  def move_dirs
    CARDINALS + DIAGONALS
  end

  def to_s
    " ♛ "
  end
end

class Pawn < Piece
  include Stepping
  PASSANT = { left: -1, right: 1 }
  attr_accessor :passant
  def to_s
    " ♟ "
  end

  def passant_set
    @passant = pawn_left? || pawn_right?
  end

  def pawn_left?
    left = [@pos[0], @pos[1] - 1]
    @board.pieces(@enemy_color).any? { |piece| piece.is_a?(Pawn) && piece.pos == left }
  end

  def pawn_right?
    right = [@pos[0], @pos[1] + 1]
    @board.pieces(@enemy_color).any? { |piece| piece.is_a?(Pawn) && piece.pos == right }
  end

  def passant_adjacent
    left = [@pos[0], @pos[1] - 1]
    right = [@pos[0], @pos[1] + 1]
    return :left if pawn_left? && @board[left].passant
    return :right if pawn_right? && @board[right].passant
    nil
  end


  def move_dirs
    deltas = []
    starting_rank = (color == :white ? 6 : 1)
    direction = (color == :white ? -1 : 1)
    deltas << [direction * 2, 0] if @pos[0] == starting_rank
    one_step_forward = [@pos[0] + direction, @pos[1]]
    deltas << [direction, 0] unless @board.pieces.any? { |piece| piece.pos == one_step_forward }
    [[direction, -1], [direction, 1]].each do |delta|
      d_x, d_y = delta
      test_pos = [@pos[0] + d_x, @pos[1] + d_y]
      deltas << delta if @board.pieces(@enemy_color).any? { |piece| piece.pos == test_pos }
    end
    deltas << [direction, PASSANT[passant_adjacent]] unless passant_adjacent.nil?
    deltas
  end

end
