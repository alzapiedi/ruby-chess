module Sliding

MOVES = { diag: [[1, 1], [-1, -1], [-1, 1], [1, -1], [2, 2], [-2, -2], [-2, 2], [2, -2], [3, 3], [-3, -3], [-3, 3], [3, -3], [4, 4], [-4, -4], [-4, 4], [4, -4], [5, 5], [-5, -5], [-5, 5], [5, -5], [6, 6], [-6, -6], [-6, 6], [6, -6], [7, 7], [-7, -7], [-7, 7], [7, -7]],
          horiz: [[1, 0], [-1, 0], [0, 1], [0, -1], [2, 0], [-2, 0], [0, 2], [0, -2], [3, 0], [-3, 0], [0, 3], [0, -3], [4, 0], [-4, 0], [0, 4], [0, -4], [5, 0], [-5, 0], [0, 5], [0, -5], [6, 0], [-6, 0], [0, 6], [0, -6], [7, 0], [-7, 0], [0, 7], [0, -7]] }

  def moves
    x, y = @pos
    dir_hash = self.move_dirs.select { |_, val| val }
    moves = []
    dir_hash.each do |dir, _|
      MOVES[dir].each { |delta| moves << [delta[0] + x, delta[1] + y] }
    end
    moves.select { |move| @board.in_bounds?(move) }
  end

  def valid_moves

  end

  def path_blocked?(end_pos)
    s_x, s_y = @pos
    d_x, d_y = end_pos
    path = []
    case [d_x <=> s_x, d_y <=> s_y]
    when [-1, 1]
      px = d_x + 1
      py = d_y - 1
      (s_x-d_x).times do
        path << [px, py]
        px += 1
        py -= 1
      end
      p path

      end

      path.any? { |pos| @board.occupied?(pos) }


  end


end
