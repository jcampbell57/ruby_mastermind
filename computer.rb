# frozen_string_literal: true

require_relative 'game_logic'

# Code maker logic
class CodeMaker
  attr_accessor :master_code, :guess, :misplaced

  include GameLogic

  def initialize
    @guess = []
    @exact = []
    @misplaced = []
    @code_numbers = %w[1 2 3 4 5 6]
  end

  def play
    @master_code = input_code
    start_game
    end_game
  end

  def input_code
    puts 'Input a code:'
    input = gets.chomp
    return input.split('') if input.match?(/^[1-6]{4}$/)

    puts '- Code must be four digits'
    puts '- Digits must be greater than or equal to 1'
    puts '- Digits must be less than or equal to 6'
    input_code
  end

  def start_game
    turn = 1
    while turn <= 12
      @guess = []
      set_exact
      set_misplaced
      set_random
      puts "Computer guess: #{@guess}"
      break if guess == master_code

      # if guess is incorrect:
      p generate_hints(guess)
      puts "Guesses left: #{12 - turn}"
      turn += 1
      sleep(0.5)
    end
  end

  def set_exact
    unless @exact.empty?
      @exact.each do |item|
        @guess[item[1]] = item[0]
      end
    end
  end

  def set_misplaced
    unless @misplaced.empty?
      4.times do |i|
        if @guess[i].nil? && @misplaced.length.positive?
          misplaced_sample = @misplaced.sample
          @guess[i] = misplaced_sample[0]
          @misplaced.delete_if { |item| item == misplaced_sample }
        end
      end
    end
  end

  def set_random
    4.times do |i|
      if @guess[i].nil?
        @guess[i] = @code_numbers.sample
      end
    end
  end

  def end_game
    if guess == master_code
      puts 'Computer wins!'
    else
      puts 'Congratulations, you beat the computer!'
    end
  end
end
