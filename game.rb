# frozen_string_literal: true
require_relative 'player'
require_relative 'computer'

# Mastermind
class Game
  def play
    game_info
    game_mode = choose_mode.to_i
    Code_breaker.new.play if game_mode == 1
    Code_maker.new.play if game_mode == 2
  end

  def game_info
    puts 'Mastermind'
    puts 'Hints:'
    puts "'X' represents a correct value in the correct position."
    puts "'O' represents a correct value in the incorrect position."
  end

  def choose_mode
    puts 'Would you like to be the Code Breaker or the Code Setter?'
    puts '1. Code Breaker'
    puts '2. Code Setter'
    puts "Input '1' for Code Breaker or '2' for Code Setter:"
    mode_selection = gets.chomp
    return mode_selection if mode_selection.match?(/^[1-2]$/)

    puts 'Invalid selection!'
    choose_mode
    # start_game
  end

  @colors = {
    '1': 'green',
    '2': 'yellow',
    '3': 'blue',
    '4': 'red',
    '5': 'orange',
    '6': 'purple'
  }
end
