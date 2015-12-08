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
    " H "
  end

  def move_dirs
    DELTAS
  end
end

class King < Piece
  include Stepping

  def to_s
    " K "
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
    " B "
  end
end

class Rook < Piece
  include Sliding

  def move_dirs
    CARDINALS
  end

  def to_s
    " R "
  end
end

class Queen < Piece
  include Sliding

  def move_dirs
    CARDINALS + DIAGONALS
  end

  def to_s
    " Q "
  end
end

class Pawn < Piece
  include Stepping
  attr_accessor :passant
  def to_s
    " P "
  end

  def move_dirs
    case color
    when :white
      deltas = []
      deltas << [-2, 0] if @pos[0] == 6
      one_step = [@pos[0] - 1, @pos[1]]
      deltas << [-1, 0] unless @board.pieces.any? { |piece| piece.pos == one_step }
      test_deltas = [[-1, -1], [-1, 1]]
      test_deltas.each do |delta|
        d_x, d_y = delta
        test_pos = [@pos[0] + d_x, @pos[1] + d_y]
        deltas << delta if @board.pieces(:black).any? { |piece| piece.pos == test_pos}
      end
      deltas
    when :black
      deltas = []
      deltas << [2, 0] if @pos[0] == 1
      one_step = [@pos[0] + 1, @pos[1]]
      deltas << [1, 0] unless @board.pieces.any? { |piece| piece.pos == one_step }
      test_deltas = [[1, -1], [1, 1]]
      test_deltas.each do |delta|
        d_x, d_y = delta
        test_pos = [@pos[0] + d_x, @pos[1] + d_y]
        deltas << delta if @board.pieces(:white).any? { |piece| piece.pos == test_pos}
      end
      deltas
    end
  end

end
