module Stepping

def moves
  x, y = @pos
  test_board = @board.deep_dup
  deltas = self.class::DELTAS
  moves = []
  deltas.each { |delta| moves << [delta[0] + x, delta[1] + y] }
  moves.select { |move| @board.in_bounds?(move) && !move_into_check?(test_board, move) && (!@board.occupied?(move) || @board[move].color != self.color) }
end

end
