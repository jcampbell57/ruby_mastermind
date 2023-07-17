# frozen_string_literal: true

# methods to initialize game
class Game
  def initialize
    self.mode = 1
    display_info
  end

  def display_info
    puts 'Lets play Mastermind in the console!'
    puts 'Hints:'
    puts "- 'X' represents a correct value in the correct position."
    puts "- 'O' represents a correct value in the incorrect position."
    puts '- Each code has four values.'
    puts "- Each value could be any number from '1' to '6'"
  end

  def prompt_game_mode
    puts 'Please select game mode: '
    puts "Input '1' for code breaker."
    puts "Input '2' for code setter."
    print 'Game mode selection: '
    self.mode = verify_mode_selection(gets.chomp.to_i)
  end

  def verify_mode_selection(integer)
    return integer if integer.between?(1, 2)

    puts "Game mode input must be '1' or '2'"
    verify_mode_selection(gets.chomp.to_i)
  end
end
