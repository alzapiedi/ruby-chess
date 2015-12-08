require_relative 'errors'
require_relative 'piece'
require_relative 'display'
require 'byebug'

class Board
BOARD_SIZE = 8
attr_reader :grid
attr_accessor :current_piece
  def initialize(grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) })
    @grid = grid
    @current_piece = nil
  end

  def checkmate?(color)
    pieces(color).each do |piece|
      return false if piece.moves.any? { |move| !piece.move_into_check?(move) }
    end
    return true
  end

  def find_king(color)
    pieces.each do |piece|
      return piece.pos if piece.is_a?(King) && piece.color == color
    end
  end

  def in_check?(color)
    king_pos = find_king(color)
    pieces.each do |piece|
      return true if piece.moves.include?(king_pos) && piece.color != color
    end
    return false
  end

  def in_bounds?(pos)
    x, y = pos
    x >= 0 && y >= 0 && x < BOARD_SIZE && y < BOARD_SIZE
  end

  def occupied?(pos)
    !self[pos].nil?
  end

  def pieces(color = nil)
    if color
      @grid.flatten.compact.select { |piece| piece.color == color }
    else
      @grid.flatten.compact
    end
  end

  def color?(pos)
    self[pos].color
  end

  def move(start, end_pos)
    piece = self[start]
    piece.pos = end_pos
    self[end_pos] = piece
    self[start] = nil
  end

  def [](arr)
    x, y = arr
    @grid[x][y]
  end
  def []=(arr, piece)
    x = arr[0]
    y = arr[1]
    @grid[x][y] = piece
  end

  def deep_dup
    test_board = Board.new
    pieces.each do |piece|
      piece.class.new(piece.color, test_board, piece.pos)
    end

    test_board
  end

  def populate
    Rook.new(:black, self, [0, 0])
    Rook.new(:black, self, [0, 7])
    Knight.new(:black, self, [0,1])
    Knight.new(:black, self, [0,6])
    Bishop.new(:black, self, [0,2])
    Bishop.new(:black, self, [0,5])
    Queen.new(:black, self, [0,3])
    King.new(:black, self, [0,4])
    Pawn.new(:black, self, [1,0])
    Pawn.new(:black, self, [1,1])
    Pawn.new(:black, self, [1,2])
    Pawn.new(:black, self, [1,3])
    Pawn.new(:black, self, [1,4])
    Pawn.new(:black, self, [1,5])
    Pawn.new(:black, self, [1,6])
    Pawn.new(:black, self, [1,7])
    Rook.new(:white, self, [7,0])
    Rook.new(:white, self, [7,7])
    Knight.new(:white, self, [7,6])
    Knight.new(:white, self, [7,1])
    Bishop.new(:white, self, [7,5])
    Bishop.new(:white, self, [7,2])
    Queen.new(:white, self, [7,3])
    King.new(:white, self, [7,4])
    Pawn.new(:white, self, [6,0])
    Pawn.new(:white, self, [6,1])
    Pawn.new(:white, self, [6,2])
    Pawn.new(:white, self, [6,3])
    Pawn.new(:white, self, [6,4])
    Pawn.new(:white, self, [6,5])
    Pawn.new(:white, self, [6,6])
    Pawn.new(:white, self, [6,7])
  end
end
