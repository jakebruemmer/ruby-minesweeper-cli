
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
    @adjacent_zeroes = {}
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
    @adjacent.each do |key, value|
      begin  
        if value.adjacent_bombs == 0
          @adjacent_zeroes[key] = value
        end
      rescue
      end
    end 
  end
  
  def play_adjacent_zeroes
    @adjacent_zeroes.each do |key, value|
      value.adjacent_zeroes.each do |key1, value1|
        if !value1.been_played  
          value1.been_played = true
          @board.num_played += 1
        end
      end
    end

  end

  def is_bomb?
    @is_bomb
  end
end

