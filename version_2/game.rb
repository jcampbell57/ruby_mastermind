# frozen_string_literal: true

# primary game logic
class Game
  attr_accessor :mode, :code, :guess_count

  def initialize
    display_info
    self.guess_count = 12
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

  # game administration methods

  def validate_input(player_input)
    if player_input.length != 4
      print 'Input a four digit code (eg: 1234): '
      validate_input(gets.chomp.to_i.to_s)
    elsif player_input.split('').all?(/[1-6]/)
      player_input
    else
      print 'Input a four digit code with digits 1-6: '
      validate_input(gets.chomp.to_i.to_s)
    end
  end

  # end game methods

  def end_game(player_input)
    if mode == 1
      process_breaker_game(player_input)
    elsif mode == 2
      process_setter_game(player_input)
    else
      p "Game mode error. This shouldn't happen."
    end
  end

  def process_breaker_game(player_input)
    if player_input == code.join
      puts "You broke the code in #{12 - guess_count} guesses!"
    elsif guess_count.zero? 0
      puts "You ran out of guesses! The code was #{code}."
    else
      puts 'I am not sure how that game ended.'
    end
    prompt_another_game
  end

  def process_setter_game
    puts 'Game over!'
  end

  def prompt_another_game
    print 'Would you like to play again? [Y/N]: '
    input = gets.chomp
    if input.upcase == 'Y'
      Game.new
    elsif input.upcase == 'N'
      puts 'Goodbye!'
      exit
    else
      puts 'Invalid input!'
      prompt_another_game
    end
  end

  # code breaker specific methods

  def code_breaker_mode
    randomize_code
    prompt_player_input
  end

  def randomize_code
    code_bank = %w[1 2 3 4 5 6]
    self.code = []
    4.times { code << code_bank.sample }
  end

  def prompt_player_input
    puts "Guesses left: #{guess_count}" if guess_count < 12
    print 'Guess the code: '
    puts "Hints: #{process_guess(validate_input(gets.chomp.to_i.to_s))}"
    prompt_player_input
  end

  def process_guess(player_guess)
    self.guess_count -= 1
    end_game(player_guess) if player_guess == code.join || guess_count.zero?
    code_copy = code.dup
    hints = []
    # mark all correct
    player_guess.split('').each_with_index do |number, index|
      next unless code_copy[index] == number

      code_copy[index] = 'X'
      hints << 'X'
      player_guess[index] = '0'
    end
    # mark all correct, but incorrect position
    player_guess.split('').each do |number|
      if code_copy.include?(number)
        code_copy[code_copy.index(number)] = 'O'
        hints << 'O'
      end
    end
    # return hints
    hints
  end

  # code setter specific methods

  def code_setter_mode; end
end
