module Sliding

MOVES = { diag: [[1, 1], [-1, -1], [-1, 1], [1, -1], [2, 2], [-2, -2], [-2, 2], [2, -2], [3, 3], [-3, -3], [-3, 3], [3, -3], [4, 4], [-4, -4], [-4, 4], [4, -4], [5, 5], [-5, -5], [-5, 5], [5, -5], [6, 6], [-6, -6], [-6, 6], [6, -6], [7, 7], [-7, -7], [-7, 7], [7, -7]],
          horiz: [[1, 0], [-1, 0], [0, 1], [0, -1], [2, 0], [-2, 0], [0, 2], [0, -2], [3, 0], [-3, 0], [0, 3], [0, -3], [4, 0], [-4, 0], [0, 4], [0, -4], [5, 0], [-5, 0], [0, 5], [0, -5], [6, 0], [-6, 0], [0, 6], [0, -6], [7, 0], [-7, 0], [0, 7], [0, -7]] }

  def moves
    x, y = @pos
    test_board = @board.deep_dup
    dir_hash = self.move_dirs.select { |_, val| val }
    moves = []
    dir_hash.each do |dir, _|
      MOVES[dir].each { |delta| moves << [delta[0] + x, delta[1] + y] }
    end
    moves.select do |move|
      (@board.in_bounds?(move) && !path_blocked?(move) && !move_into_check?(test_board, move) && (!@board.occupied?(move) || @board[move].color != self.color))
    end
  end

  def path_blocked?(end_pos)
    start_r, start_c = @pos
    end_r, end_c = end_pos
    path = []
    case [end_r <=> start_r, end_c <=> start_c]
    when [-1, 1]
      dr = end_r + 1
      dc = end_c - 1
      (start_r - end_r - 1).times do
        path << [dr, dc]
        dr += 1
        dc -= 1
      end
    when [-1, -1]
      dr = end_r + 1
      dc = end_c + 1
      (start_r - end_r - 1).times do
        path << [dr, dc]
        dr += 1
        dc += 1
      end
    when [1, -1]
      dr = end_r - 1
      dc = end_c + 1
      (end_r - start_r - 1).times do
        path << [dr, dc]
        dr -= 1
        dc += 1
      end
    when [1, 1]
      dr = end_r - 1
      dc = end_c - 1
      (end_r - start_r - 1).times do
        path << [dr, dc]
        dr -= 1
        dc -= 1
      end
    when [1, 0]
      ((start_r + 1).upto(end_r - 1)).each do |r|
        path << [r, start_c]
      end
    when [-1, 0]
      ((end_r - 1).downto(start_r + 1)).each do |r|
        path << [r, start_c]
      end
    when [0, 1]
      ((start_c + 1).upto(end_c - 1)).each do |c|
        path << [start_r, c]
      end
    when [0, -1]
      ((end_c - 1).downto(start_c + 1)).each do |c|
        path << [start_r, c]
      end
      end
      path.any? { |pos| @board.occupied?(pos) }
  end
end
