# frozen_string_literal: true

# game logic
class Game

  def initialize

  end

  def self.choose_mode
    puts 'Mastermind'
    puts 'Hints:'
    puts "'X' represents a correct value in the correct position."
    puts "'O' represents a correct value in the incorrect position."
    puts 'Would you like to be the Code Breaker or the Code Setter?'
    puts '1. Code Breaker'
    puts '2. Code Setter'
    puts "Input '1' for Code Breaker and '2' for Code Setter:"
    @mode_selection = gets.chomp.to_i
    start_game
  end

  def self.start_game
    case @mode_selection
    when 1
      @master_code = generate_code
      12.times do
        puts 'Guess the code:'
        user_guess
      end
      # user_guess
      p 'Correct solution:'
      p @master_code
    when 2
      puts 'Input a code:'
      @master_code = gets.chomp
      puts @master_code
    else
      puts 'Invalid selection!'
      choose_mode
    end
  end

  @rounds = 12
  @mode_selection = 0
  @master_code = []
  @code_numbers = ['1', '2', '3', '4', '5', '6']
  
  @colors = {
    '1': 'green',
    '2': 'yellow',
    '3': 'blue',
    '4': 'red',
    '5': 'orange',
    '6': 'purple'
  }

  def self.generate_code
    new_code = []
    4.times { new_code << @code_numbers.sample }
    new_code
  end

  def self.user_guess
    user_guess = gets.chomp
    validate_code(user_guess)
  end

  def self.check_for_victory(guess)
    if guess == @master_code
      puts 'Congratulation, you broke the code!'
      exit
    end
  end

  def self.validate_code(guess)
    if guess.length > 4
      puts 'Code too long, please input four digits:'
      # user_guess
      # exit
      # break
    elsif guess.length < 4
      puts 'Code too short, please input four digits:'
      # user_guess
      # exit
      # break
    else
      guess = guess.split('')
      check_for_victory(guess)
      p generate_hints(guess)
    end
  end

  def self.generate_hints(guess)
    hints = []

    # create copy of guess
    guess_copy = []
    guess_copy.replace(guess)

    # create copy of master code
    master_copy = []
    master_copy.replace(@master_code)

    # find exact match
    guess_copy.each_with_index do |item, index|
      if master_copy[index] == item
        hints.unshift('X')
        master_copy[index] = '7'
        guess_copy[index] = '8'
      elsif master_copy.include?(item) && master_copy[index] != item
        doomed_index = master_copy.find_index(item)
        # check to see if there is exact match
        unless guess_copy[doomed_index] == master_copy[doomed_index]
          hints.push('0')
          # remove item from master copy so it doesnt get flagged again if user put the same number multiple times.
          master_copy[doomed_index] = '7'
        end
        # guess_copy[index] = 8
      end
    end

    # p "original guess:  #{guess}"
    # p "original master: #{@master_code}"
    # p "guess copy:      #{guess_copy}"
    # p "master copy:     #{master_copy}"

    hints
  end
end

# Mastermind.start_game
Game.choose_mode
