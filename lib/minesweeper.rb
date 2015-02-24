#!/usr/bin/env ruby
require_relative 'game_tile'
require_relative 'minesweeper_game'
require_relative 'game_board'

puts "Welcome to the game of minesweeper!"
puts "-----------------------------------"
puts "Please enter the amount of rows that you would like to play with, anything more than 20 will be truncated."
rows = gets.chomp

while /^(\d){1,2}\z/.match(rows) == nil do
  puts "Please enter the amount of rows that you would like to play with, anything more than 20 will be truncated."
  rows = gets.chomp
end

# Ternary statement to truncate the rows if value entered is greater than 20
if rows.to_i > 20 then rows = 20 else rows = rows.to_i end

puts "Please enter the amount of cols that you would like to play with, anything more than 20 will be truncated."
cols = gets.chomp

while /^(\d){1,2}\z/.match(cols) == nil do
  puts "Please enter the amount of cols that you would like to play with, anything more than 20 will be truncated."
  cols = gets.chomp
end

# Ternary statement to truncate the cols if value entered is greater than 20
if cols.to_i > 20 then cols = 20 else cols = cols.to_i end

puts "Please enter the % chance you want for a bomb to occur"
puts "This number needs to be between 0 and 1"
bomb_chance = gets.chomp.to_f

while !bomb_chance.is_a?(Float) || bomb_chance > 1.0 || bomb_chance < 0.0 do
  puts "Please enter the % chance you want for a bomb to occur"
  puts "This number needs to be between 0 and 1"
  bomb_chance = gets.chomp.to_f
end

# Create the board
board = GameBoard.new(rows, cols, bomb_chance)


# Use the MinesweeperGame class to play the game
game = MinesweeperGame.new(board, rows, cols)

game.print_the_board
while !game.game_over? && !game.win? do
 game.play_the_game
end

if game.game_over?
  puts "Oops! You selected a bomb. Please play again!"
elsif game.win?
  puts "Congrats you won the game!"
end

