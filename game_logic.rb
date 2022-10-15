module GameLogic
  def generate_hints(guess)
    hints = []

    # create copy of guess
    guess_copy = []
    guess_copy.replace(guess)

    # create copy of master code
    master_copy = []
    master_copy.replace(@master_code)

    guess_copy.each_with_index do |item, index|
      # find exact match
      if master_copy[index] == item
        hints.unshift('X')
        master_copy[index] = '7'
        guess_copy[index] = '8'
      # find match in wrong location
      elsif master_copy.include?(item) && master_copy[index] != item
        doomed_index = master_copy.find_index(item)
        # check to see if there is exact match
        unless guess_copy[doomed_index] == master_copy[doomed_index]
          hints.push('0')
          # remove item from master copy so it doesnt get flagged again if user put the same number multiple times.
          master_copy[doomed_index] = '9'
        end
        # guess_copy[index] = 8
      end
    end

    p "original guess:  #{guess}"
    p "original master: #{@master_code}"
    p "guess copy:      #{guess_copy}"
    p "master copy:     #{master_copy}"

    hints
  end
end