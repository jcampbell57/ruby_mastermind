# frozen_string_literal: true

# primary game logic
class Game
  attr_accessor :mode, :code, :guess_count

  @@computer_guesses = { exact: [], misplaced: [] }

  def initialize
    display_info
    self.guess_count = 12
    prompt_game_mode
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
      @@computer_guesses[:exact][index] = number
    end
    # mark all correct, but incorrect position
    player_guess.split('').each do |number|
      next unless code_copy.include?(number)

      code_copy[code_copy.index(number)] = 'O'
      hints << 'O'
      @@computer_guesses[:misplaced] << number
    end
    # return hints
    hints
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
    elsif guess_count.zero?
      puts "You ran out of guesses! The code was #{code}."
    else
      puts 'I am not sure how that game ended.'
    end
    prompt_another_game
  end

  def process_setter_game(computer_input)
    if computer_input == code.join
      puts "The computer broke the code in #{12 - guess_count} guesses!"
    elsif guess_count.zero?
      puts "The computer ran out of guesses! You won with the code #{code}."
    else
      puts 'I am not sure how that game ended.'
    end
    prompt_another_game
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

  # code setter specific methods

  def code_setter_mode
    print 'Enter a code for the computer to break: '
    self.code = validate_input(gets.chomp.to_i.to_s).split('')
    computer_move
  end

  def computer_move
    # mark known guesses
    current_guess = @@computer_guesses[:exact].dup
    puts "Guesses left: #{guess_count}" if guess_count < 12
    print 'Computer guess is: '
    4.times do |i|
      # place guesses
      if !@@computer_guesses[:misplaced].nil? && current_guess[i].nil?
        current_guess[i] = @@computer_guesses[:misplaced].sample
        @@computer_guesses[:misplaced].delete(current_guess[i])
      end
      current_guess[i] = %w[1 2 3 4 5 6].sample if current_guess[i].nil?
      sleep 0.3
      print "#{current_guess[i]}"
    end
    puts
    puts @@computer_guesses[:misplaced]
    puts "Hints: #{process_guess(current_guess.join)}"
    computer_move
  end
end
