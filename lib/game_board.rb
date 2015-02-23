# GameBoard class will be used by the minesweeper game to keep track of tiles, 
# bombs, and the conditions necessary to win the game.
require 'game_tile'

class GameBoard

  attr_accessor :rows, :cols, :board, :num_played, :win_value
  
  def initialize(rows, cols, bomb_chance)
    @board = {}
    @num_played = 0
    @win_value = rows * cols
    # This sets the board's values and then checks for some of the bombs
    rows.times do |row|
      cols.times do |column|
        if rand < bomb_chance
          @board["(#{row}, #{column})"] = GameTile.new(self, nil, nil, nil, nil, nil, nil, nil, nil, true)
          @win_value -= 1
        else
          @board["(#{row}, #{column})"] = GameTile.new(self, nil, nil, nil, nil, nil, nil, nil, nil, false)
        end


        # Set the left pointers to GameTile objects that have already been created.
        if column > 0
          @board["(#{row}, #{column})"].adjacent["left"] = @board["(#{row}, #{column - 1})"]
        end
       
        # Set the up_left, up, and up_right pointers to objects that have been created. Edge 
        # cases are automatically handled because Hashes return nil for keys that do not 
        # exist in the hash.
        if row > 0
          @board["(#{row}, #{column})"].adjacent["up"] = @board["(#{row - 1}, #{column})"]
          @board["(#{row}, #{column})"].adjacent["up_left"] = @board["(#{row - 1}, #{column - 1})"]
          @board["(#{row}, #{column})"].adjacent["up_right"] = @board["(#{row - 1}, #{column + 1})"]
        end
      end
    end

    # Now finish the bomb checking 
    rows.times do |row|
      cols.times do |column|

        # Set the right pointer object based on objects that have already been created.
        if column < cols - 1
          @board["(#{row}, #{column})"].adjacent["right"] = @board["(#{row}, #{column + 1})"]
        end

        if row < rows - 1
          @board["(#{row}, #{column})"].adjacent["down_left"] = @board["(#{row + 1}, #{column - 1})"]
          @board["(#{row}, #{column})"].adjacent["down"] = @board["(#{row + 1}, #{column})"]
          @board["(#{row}, #{column})"].adjacent["down_right"] = @board["(#{row + 1}, #{column + 1})"]
        end

      end
    end

    # Search for bombs
    @board.each do |key, value|
      value.find_adjacent_bombs
      value.find_adjacent_zeroes
    end
  end
end

