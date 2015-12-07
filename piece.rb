require_relative 'sliding'
require_relative 'stepping'
class Piece
  attr_reader :color, :color_option, :board
  attr_accessor :pos
  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
    @board[@pos] = self
    @color_option = (@color == :white ? :green : :light_blue)
  end

end

class Knight < Piece
  include Stepping
  DELTAS = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]
  def to_s
    " H "
  end
end

class King < Piece
  include Stepping
  DELTAS = [[-1, -1], [-1, 0], [-1, 1], [0, 1], [0, -1], [1, -1], [1, 0], [1, 1]]
  def to_s
    " K "
  end
end

class Bishop < Piece
  include Sliding
  def move_dirs
    { diag: true, horiz: false }
  end
  def to_s
    " B "
  end
end

class Rook < Piece
  include Sliding
  def move_dirs
    { diag: false, horiz: true }
  end
  def to_s
    " R "
  end
end

class Queen < Piece
  include Sliding
  def move_dirs
    { diag: true, horiz: true }
  end
  def to_s
    " Q "
  end
end

class Pawn < Piece
  include Stepping
  def to_s
    " P "
  end
end
