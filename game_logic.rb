# frozen_string_literal: true

# Game logic methods
module GameLogic
  def generate_hints(guess)
    hints = []

    guess_copy = guess.clone
    master_copy = @master_code.clone

    exact_matches = exact_matches?(guess_copy, master_copy)
    misplaced_matches = misplaced_matches?(guess_copy, master_copy)

    exact_matches.times { hints.unshift('X') }
    misplaced_matches.times {hints.push('O')}

    # debugging:
    # p "original guess:  #{guess}"
    # p "original master: #{@master_code}"
    # p "guess copy:      #{guess_copy}"
    # p "master copy:     #{master_copy}"

    hints
  end

  def exact_matches?(guess_copy, master_copy)
    exact_match_count = 0
    guess_copy.each_with_index do |item, index|
      # find exact match
      if master_copy[index] == item
        exact_match_count += 1
        @exact << [item, index]
        # remove item from master copy so it doesnt get flagged again.
        master_copy[index] = '7'
        guess_copy[index] = '8'
      end
    end
    exact_match_count
  end

  def misplaced_matches?(guess_copy, master_copy)
    misplaced_match_count = 0
    # find match in wronmisplaced_match_countg location
    guess_copy.each_with_index do |item, index|
      if master_copy.include?(item) && master_copy[index] != item
        doomed_index = master_copy.find_index(item)
        # check exact match?
        unless guess_copy[doomed_index] == master_copy[doomed_index]
          misplaced_match_count += 1
          @misplaced << [item, index]
          # remove item from master copy so it doesnt get flagged again.
          master_copy[doomed_index] = '7'
        end
        # guess_copy[index] = 8
      end
    end
    misplaced_match_count
  end
end
