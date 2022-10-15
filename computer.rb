require_relative "game_logic.rb"

class Code_maker
  attr_accessor :master_code

  include GameLogic

  def initialize

  end

  def play 
    puts 'Input a code:'
    master_code = gets.chomp
    puts master_code
  end

end