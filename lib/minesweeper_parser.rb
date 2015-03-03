require 'optparse'
require 'ostruct'
require 'pp'

# Include this line in order to show a help message if there are no args
ARGV << "-h" if ARGV.empty?

class MinesweeperParser
  def initialize
  end

  def parse(args)
    options = OpenStruct.new
    options.rows_cols_chance = {}
    options.inplace = false
    options.encoding = "utf8"
    options.transfer_type = :auto
    options.verbose = false

    # Here is where we make the options parser
    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: minesweeper [options]"
      
      opts.on("-r ROWS", "--rows ROWS", Integer, "Specify the number of rows that you'd like your game to have. Truncated at 20.") do |rows|
        if rows > 20 then rows = 20 elsif rows < 1 then rows = 1 end
        options.rows_cols_chance[:rows] = rows
      end

      opts.on("-c COLUMNS", "--columns COLUMNS", Integer, "Specify the number of columns that you'd like your game to have. Truncated at 20.") do |cols|
        if cols > 20 then cols = 20 elsif cols < 1 then cols = 1 end
        options.rows_cols_chance[:cols] = cols
      end

      opts.on("-f BOMB_CHANCE", "--frequency BOMB_CHANCE", Float, "Specify frequency that bombs will appear on your board. Must be [0, 1].") do |chance|
        if chance > 1.0 then chance = 1.0 elsif chance < 0.0 then chance = 0.0 end
        options.rows_cols_chance[:bomb_chance] = chance
      end
      
      opts.on_tail("-h", "--help", "Show this message") do 
        puts opts
        exit
      end

       
    end

    opt_parser.parse!(args)
    options
  end
end

