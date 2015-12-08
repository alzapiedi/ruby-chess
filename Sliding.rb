module Sliding

  def moves
    moves = []
    move_dirs.each do |delta|
      d_x, d_y = delta
      test_position = [@pos[0] + d_x, @pos[1] + d_y]
      next unless @board.in_bounds?(test_position)
      until !@board.in_bounds?(test_position)|| @board.occupied?(test_position)
        moves << test_position
        test_position = [test_position[0] + d_x, test_position[1] + d_y]
      end
      moves << test_position if @board.in_bounds?(test_position) && @board.occupied?(test_position) && @board[test_position].color != self.color
    end
    moves
  end

 
end
