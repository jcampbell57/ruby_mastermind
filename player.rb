# frozen_string_literal: true

require_relative 'game_logic'

# Code breaker logic
class CodeBreaker
  attr_accessor :master_code, :guess

  include GameLogic

  def initialize 
    @master_code = generate_code
  end

  def generate_code
    code_numbers = %w[1 2 3 4 5 6]
    # new_code = ['5', '4', '4', '1']
    new_code = []
    4.times { new_code << code_numbers.sample }
    new_code
  end

  def play
    start_game
    end_game
  end

  def start_game
    turn = 1
    while turn <= 12
      @guess = user_guess
      break if guess == master_code

      # if guess is incorrect:
      p generate_hints(guess)
      puts "Guesses left: #{12 - turn}"
      turn += 1
    end
  end

  def user_guess
    puts 'Guess the code:'
    user_input = gets.chomp
    return user_input.split('') if user_input.match?(/^[1-6]{4}$/)

    # when user guess is invalid:
    puts '- Your guess must be four digits'
    puts '- Digits must be greater than or equal to 1'
    puts '- Digits must be less than or equal to 6'
    user_guess
  end

  def end_game
    if guess == master_code
      puts 'Congratulation, you broke the code!'
    else
      puts 'Better luck next time'
    end
  end
end
