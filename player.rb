require_relative "game_logic.rb"

class Code_breaker
  attr_accessor :master_code, :guess

  include GameLogic

  def initialize 
    @master_code = generate_code
  end

  def generate_code
    code_numbers = ['1', '2', '3', '4', '5', '6']
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
    while turn <=12
      puts "Guess the code:"
      @guess = user_guess.split('')
      break if guess == master_code
      p generate_hints(guess)
      puts "Guesses left: #{12-turn}"
      turn += 1
    end
  end

  def user_guess
    user_guess = gets.chomp
    return user_guess if user_guess.match?(/^[0-6]{4}$/)
    puts 'Your guess must be four digits'
    puts 'Digits must be greater than or equal to 1'
    puts 'Digits must be less than or equal to 6'
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