






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
  deltas << [direction, -1] if passant_left?
  deltas << [direction, 1] if passant_right?
  deltas
end
