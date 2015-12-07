module Stepping

def moves
  x, y = @pos
  deltas = self.class::DELTAS
  moves = []
  deltas.each { |delta| moves << [delta[0] + x, delta[1] + y] }
  moves.select { |move| @board.in_bounds?(move) }
end

end
