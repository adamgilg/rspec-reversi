require 'rspec'
require_relative './reversi.rb'

include Reversi

describe Board do
  subject(:board) { Board.new }
#very concise.
  its(:grid) {should == Array.new(8) {Array.new(8)}}

  describe '#setup_board' do

    it 'generates the default setup' do
      board.setup_board
      center = [board.grid[3][3], board.grid[3][4], board.grid[4][3], board.grid[4][4]]
      center.should == ["W", "B", "B", "W"]
    end

    it 'generates the custom grid' do
      grid = [[nil, nil], ["W", "W"]]
      board.setup_board(grid)
      board.grid.should == grid
    end
  end


  describe '#straight_paths' do
    let(:grid) { [[nil, nil, nil, "W"],
                  [nil, "B", nil, "B"],
                  [nil, "W", "B", nil],
                  [nil, nil, nil, "W"]]}
    before(:each) {board.setup_board(grid)}

    it 'returns a single path of coordinates to flip' do
      board.straight_paths([0, 1], "W").should == [[1, 1]]
    end

    it 'returns multiple paths of coordinates to flip' do
      board.straight_paths([2, 3], "W").should =~ [[2, 2], [1, 3]]
    end

    it 'returns an empty array if no discs are to be flipped' do
      board.straight_paths([0, 2], "W").should == []
    end
  end

  describe '#diagonal_paths' do
    let(:grid) { [[nil, nil, nil, nil, "W"],
                  [nil, "W", nil, "B", nil],
                  [nil, nil, nil, nil, nil],
                  [nil, "B", nil, "B", nil],
                  [nil, nil, nil, nil, "W"]]}
    before(:each) { board.setup_board(grid) }

    it 'returns the paths of coordinates to flip' do
      board.diagonal_paths([2, 2], "W").should =~ [[1, 3], [3, 3]]
    end

    it 'returns an empty array if no discs are to be flipped' do
      board.diagonal_paths([4, 0], "W").should == []
    end
  end

  describe '#flip_discs' do
    let(:grid) { [[nil, nil, nil, "W"],
                  [nil, "B", nil, "B"],
                  [nil, "W", "B", nil],
                  [nil, nil, nil, "W"]]}
    before(:each) do
      board.setup_board(grid)
      board.flip_discs([[1, 1], [2, 1]])
    end

    it 'flips the discs at the passed in positions' do
      board.grid[1][1].should == "W"
      board.grid[2][1].should == "B"
    end

    it 'does not flip other discs' do
      board.grid[0][3].should == "W"
      board.grid[1][3].should == "B"
    end
  end
  describe '#place_disc' do
    let(:grid) { [[nil, nil, nil, "W"],
                  [nil, "B", nil, "B"],
                  [nil, "W", "B", nil],
                  [nil, nil, nil, "W"]]}
    before(:each) do
      board.setup_board(grid)
      board.place_disc([0, 0], "W")
    end

    it 'places the correct disc at the correct position' do
      board.grid[0][0].should == "W"
    end
  end
end

 describe HumanPlayer do

 end 

# describe ComputerPlayer
# describe Game
