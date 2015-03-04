
# An object oriented take on the minesweeper game that's done in 131.
# Since it is un-Rubylike to use 2d arrays, I'm going to try and 
# make the game using a more object oriented approach.

class GameTile

  attr_accessor :adjacent, :adjacent_bombs, :been_played, :been_flagged, :adjacent_zeroes

  def initialize(board, up_left, up, up_right, left, right, down_left, down, down_right, is_bomb)
    @adjacent = {
      "up_left" => up_left,
      "up" => up,
      "up_right" => up_right,
      "left" => left,
      "right" => right,
      "down_left" => down_left,
      "down" => down,
      "down_right" => down_right
    }
    @is_bomb = is_bomb
    @adjacent_bombs = 0
    @adjacent_zeroes = []
    @been_played = false
    @been_flagged = false
    @board = board
  end

  # Method will iterate through the surrounding GameTiles to check how many bombs there are.
  # The method returns the number of bombs that are adjacent to itself.
  def find_adjacent_bombs
    @adjacent.each do |key, value|
      begin
        if value.is_bomb?
          @adjacent_bombs += 1
        end
      rescue
        # This rescue catches the NoMethodError that arises when trying to call the find_adjacent_bombs 
        # method on an edge cell. The error arises when trying to access the is_bomb attribute of a 
        # nil class. Hence, the NoMethodError.
      end
    end
  end

  # This method will "play" all of the adjacent cells that have zero mines surrounding them.
  # The minesweeper game that comes standard with most computers has this behavior.
  def find_adjacent_zeroes
    @adjacent.each do |key, tile|
      begin  
        if tile.adjacent_bombs == 0
          @adjacent_zeroes << tile
        end
      rescue
      end
    end 
  end
  
  # Recusively play all of the zero tiles around the tile that has been played.
  # The recursion stops when the method reaches a tile that has adjacent bombs.
  def play_adjacent_zeroes(board)
    if @adjacent_bombs > 0
      @been_played = true
      board.num_played += 1
      return
    else
      board.num_played += 1 unless !@been_played
      @been_played = true
      @adjacent.each do |key, tile|
        if !tile.nil? && !tile.been_played
          tile.been_played = true
          tile.play_adjacent_zeroes(board)
        end
      end
    end

  end

  def is_bomb?
    @is_bomb
  end
end

