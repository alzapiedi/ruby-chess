module Stepping

  def moves
    moves = []
    move_dirs.each do |delta|
      d_x, d_y = delta
      test_position = [@pos[0] + d_x, @pos[1] + d_y]
      next unless @board.in_bounds?(test_position)
      moves << test_position unless @board.occupied?(test_position) && @board[test_position].color == self.color
    end
    moves
  end

 
end
