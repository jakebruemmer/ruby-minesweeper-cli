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
    puts "Numbers greater than the number of rows or cols will be truncated to the max row/col"
    puts
    player_choice = gets.chomp

    if /^(help|h)\z/.match(player_choice) then print_help_message end

    # Now match the player response with a regular expression
    while /^([pfPF]) (\d){1,2}, (\d){1,2}\z/.match(player_choice) == nil
      puts "Please put two numbers corresponding to the row and column that you'd like to play in the form"
      puts "<pf> <row>, <column>"
      puts "Numbers greater than the number of rows or cols will be truncated to the max row/col"
      puts
      player_choice = gets.chomp
      if /^(help|h)\z/.match(player_choice) then print_help_message end
    end
    match = /^([pfPF]) (\d){1,2}, (\d){1,2}\z/.match(player_choice)
    row = match[2].to_i
    col = match[3].to_i

    if row > @rows then row = @rows end
    if col > @columns then col = @columns end

    # A 'p' character indicates that the player wants to "play" the tile.
    # An 'f' character indicates that the player would like to flag the
    # tile because they believe there to be a bomb there. Flagged tiles
    # may still be played after they have been flagged.
    if match[1] == 'p' || match[1] == 'P'
      play_tile(row - 1, col - 1)
    elsif match[1] == 'f' || match[1] == 'F'
      flag_tile(row - 1, col - 1)
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
  
  private
    def print_help_message
      puts """ 
      This is a command line port of the game of minesweeper. It's supposed to be like
      the minesweeper game that comes standard with most operating systems, but the 
      functionality is a little different because it's just command line based. In 
      order to make a move you can just put in something like:

      p 1, 2

      where the coordinates are number starting at 1, 1 in the upper left corner to 
      rows, cols for the number of rows and columns that you put in at the start of the
      game. If you play something like:

      f 1, 2

      then that location will be flagged (|>) and marked as played. You can win the 
      game while still having marked tiles. 

      Good luck!
      """
      print_the_board
    end


end

