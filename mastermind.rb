class Mastermind
  public

  def self.start_game
    @master_code = generate_code
    puts 'Guess the code:'
    user_guess
    p @master_code
  end

  private

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
    validate_guess(user_guess)
  end

  def self.validate_guess(guess)
    if guess.length > 4
      puts 'Guess too long, please input four digits:'
      user_guess
    end
    guess = guess.split('')
    # p guess
    process_guess(guess)
    # puts guess
    # puts guess.length
    # puts guess.to_i.integer?
    # puts guess.to_i
    # p guess
    # p guess.length
    # p guess.integer?
  end

  def self.process_guess(guess)
    hints = []
    guess.each_with_index do |item, index|
      if @master_code[index] == item
        hints[index] = "X"
      end
    end
    p hints
  end
end

Mastermind.start_game
