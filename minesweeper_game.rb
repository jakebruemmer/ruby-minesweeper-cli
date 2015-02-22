class MinesweeperGame
  
  attr_accessor :board

  def initialize(board, rows, columns)
    @board = board
    @rows = rows
    @columns = columns
    @game_over = false
    @win = false
  end

  def print_the_board
    @rows.times do |row|
      @columns.times do |column|
        if !@board.board["(#{row}, #{column})"].been_played
          print "[  ] "
        elsif @board.board["(#{row}, #{column})"].been_flagged
          print "[|>] "
        else
          if @board.board["(#{row}, #{column})"].adjacent_bombs > 0 
            print "[ " + @board.board["(#{row}, #{column})"].adjacent_bombs.to_s + "] "
          else
            print "[--] "
          end
        end
      end
      puts
    end
  end

  def play_the_game
    puts "Please put two numbers corresponding to the row and column that you'd like to play in the form"
    puts "<pf> <row>, <column>"
    puts
    player_choice = gets.chomp

    # Now match the player response with a regular expression
    while /([pf]) (\d), (\d)$/.match(player_choice) == nil
      puts "Please put two numbers corresponding to the row and column that you'd like to play in the form"
      puts "<pf> <row>, <column>"
      puts
      player_choice = gets.chomp
    end
    match = /([pf]) (\d), (\d)$/.match(player_choice)    
    # A 'p' character indicates that the player wants to "play" the tile.
    # An 'f' character indicates that the player would like to flag the
    # tile because they believe there to be a bomb there. Flagged tiles
    # may still be played after they have been flagged.
    if match[1] == 'p'
      play_tile(match[2].to_i - 1, match[3].to_i - 1)
    elsif match[1] == 'f'
      flag_tile(match[2].to_i - 1, match[3].to_i - 1)
    end
    puts
    print_the_board
  end

  def play_tile(row, column)
    if @board.board["(#{row}, #{column})"].is_bomb?
      @game_over = true
    else
      @board.board["(#{row}, #{column})"].been_played = true
      @board.num_played += 1
      if @board.board["(#{row}, #{column})"].adjacent_bombs == 0
        @board.board["(#{row}, #{column})"].play_adjacent_zeroes
      end
      if @board.num_played == @board.win_value
        @win = true
      end
    end
  end
 
  def flag_tile(row, column)
    if @board.board["(#{row}, #{column})"].been_flagged
      @board.board["(#{row}, #{column})"].been_flagged = false
    else
      @board.board["(#{row}, #{column})"].been_flagged = true
      @board.board["(#{row}, #{column})"].been_played = true
      @board.num_played += 1
      if @board.num_played == @board.win_value
        @win = true
      end
    end
  end

  def game_over?
    @game_over
  end

  def win?
    @win
  end
  
end

