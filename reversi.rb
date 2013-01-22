
module Reversi
  class Board
    attr_reader :grid

    def initialize
      @grid = Array.new(8) {Array.new(8)}
    end

    def setup_board(grid = nil)
      if grid.nil?
        @grid[3][3], @grid[4][4] = "W", "W"
        @grid[3][4], @grid[4][3] = "B", "B"
        @length = 8
      else
        @grid = grid
        @length = grid.length
      end
    end

    def straight_paths(pos, color)
      directions = [[1, 0], [-1, 0], [0, 1], [0, -1]]
      paths(directions, pos, color)
    end

    def diagonal_paths(pos, color)
      directions = [[1, 1], [-1, -1], [-1, 1], [1, -1]]
      paths(directions, pos, color)
    end


    def paths(directions, pos, color)
      paths = []

      directions.each do |change|
        path = []
        step = pos.dup
        while true
          2.times {|i| step[i] += change[i]}

          break unless valid_square?(step, path, color)

          if @grid[step[0]][step[1]] == color
            paths.concat(path)
            break
          else
            path << step.dup
          end
        end
      end
      paths
    end

    def valid_square?(pos, path, color)
      return false if pos[0] >= @length || pos[1] >= @length
      grid_square = @grid[pos[0]][pos[1]]
      return false if path.empty? && grid_square == color
      return false if grid_square.nil?
      true
    end

    def flip_discs(path)
      path.each do |pos|
        if @grid[pos[0]][pos[1]] == "W"
          @grid[pos[0]][pos[1]] = "B"
        else
          @grid[pos[0]][pos[1]] = "W"
        end
      end
    end

    def place_disc(pos, color)
      @grid[pos[0]][pos[1]] = color
    end

  end

  class HumanPlayer
  end

  class ComputerPlayer
  end

  class Game
  end

end