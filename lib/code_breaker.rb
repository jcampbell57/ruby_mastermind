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
