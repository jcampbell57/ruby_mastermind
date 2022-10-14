class Mastermind
  public

  def self.start_game
    @master_code = generate_code
    12.times do 
      puts 'Guess the code:'
      user_guess 
    end
    # user_guess
    p 'Correct solution:'
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
      # user_guess
      # exit
      # break
    elsif guess.length < 4
      puts 'Guess too short, please input four digits:'
      # user_guess
      # exit
      # break
    else
      guess = guess.split('')
      if guess == @master_code
        puts 'Congratulation, you broke the code!'
        exit
      end
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
        hints << 'X'
        master_copy[index] = '7'
        guess_copy[index] = '8'
      end
    end

    # find match in wrong location
    guess_copy.each_with_index do |item, index|
      if master_copy.include?(item) && master_copy[index] != item
        hints << '0'
        doomed_index = master_copy.find_index(item)
        master_copy[doomed_index] = '7'
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

Mastermind.start_game
