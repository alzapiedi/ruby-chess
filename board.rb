require_relative 'errors'
require_relative 'piece'
require_relative 'display'
require 'byebug'

class Board
BOARD_SIZE = 8
attr_reader :grid
  def initialize(grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) })
    @grid = grid
  end

  def checkmate?(color)

  end

  def find_king(color)
    grid.each_with_index do |row, row_i|
      row.each_with_index do |piece, col_i|
        next if piece.nil?
        if piece.is_a?(King) && piece.color == color
          return [row_i, col_i]
        end
      end
    end
  end

  def in_check?(color)
    king_pos = find_king(color)
    grid.each do |row|
      row.each do |piece|
        next if piece.nil?
        return true if piece.moves.include?(king_pos)
      end
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
    new_grid = []
    @grid.each do |row|
      col = []
      row.each do |piece|
        byebug
        col << (piece.nil? ? nil : piece.dup)
      end
      new_grid << col
    end
    Board.new(new_grid)
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
    # Pawn.new(:black, self, [1,0])
    # Pawn.new(:black, self, [1,1])
    # Pawn.new(:black, self, [1,2])
    # Pawn.new(:black, self, [1,3])
    # Pawn.new(:black, self, [1,4])
    # Pawn.new(:black, self, [1,5])
    # Pawn.new(:black, self, [1,6])
    # Pawn.new(:black, self, [1,7])
    Rook.new(:white, self, [7,0])
    Rook.new(:white, self, [7,7])
    Knight.new(:white, self, [7,6])
    Knight.new(:white, self, [7,1])
    Bishop.new(:white, self, [7,5])
    Bishop.new(:white, self, [7,2])
    Queen.new(:white, self, [7,3])
    King.new(:white, self, [7,4])
    # Pawn.new(:white, self, [6,0])
    # Pawn.new(:white, self, [6,1])
    # Pawn.new(:white, self, [6,2])
    # Pawn.new(:white, self, [6,3])
    # Pawn.new(:white, self, [6,4])
    # Pawn.new(:white, self, [6,5])
    # Pawn.new(:white, self, [6,6])
    # Pawn.new(:white, self, [6,7])
  end
end
