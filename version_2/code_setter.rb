def code_setter_mode
  print 'Enter a code for the computer to break: '
  self.code = validate_input(gets.chomp.to_i.to_s).split('')
  computer_move
end

def computer_move
  # mark known guesses
  current_guess = computer_guesses[:exact].dup
  puts "Guesses left: #{guess_count}" if guess_count < 12
  print 'Computer guess is: '
  4.times do |i|
    # place guesses
    if !computer_guesses[:misplaced].nil? && current_guess[i].nil?
      current_guess[i] = computer_guesses[:misplaced].sample
      computer_guesses[:misplaced].delete(current_guess[i])
    end
    current_guess[i] = computer_guesses[:possible].sample if current_guess[i].nil?
    sleep 0.3
    print "#{current_guess[i]}"
  end
  sleep 0.3
  puts
  puts "Hints: #{process_guess(current_guess.join)}"
  computer_move
end
