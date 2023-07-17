# frozen_string_literal: true

# primary game logic
class Game
  attr_accessor :mode, :code

  def initialize
    display_info
    # prompt_game_mode
    self.mode = 1
    start_game
  end

  # methods to initialize game

  def display_info
    puts 'Lets play Mastermind in the console!'
    puts 'Game Info:'
    puts '- The code breaker has 12 guesses to break the code.'
    puts '- Each code has four values.'
    puts "- Each value could be any number from '1' to '6'"
    puts 'Hints:'
    puts "- 'X' represents a correct value in the correct position."
    puts "- 'O' represents a correct value in the incorrect position."
  end

  def prompt_game_mode
    print "Input '1' for code breaker mode or '2' for code setter mode: "
    self.mode = verify_mode_selection(gets.chomp.to_i)
  end

  def verify_mode_selection(integer)
    return integer if integer.between?(1, 2)

    print "Game mode input must be '1' or '2': "
    verify_mode_selection(gets.chomp.to_i)
  end

  def start_game
    mode == 1 ? code_breaker_mode : code_setter_mode
  end

  # code breaker

  def code_breaker_mode
    randomize_code
  end

  def randomize_code
    code_bank %w[1 2 3 4 5 6]
    self.code = []
    4.times { code << code_bank.sample }
  end

  # code setter

  def code_setter_mode; end
end
