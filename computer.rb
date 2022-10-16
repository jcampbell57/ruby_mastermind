# frozen_string_literal: true

require_relative 'game_logic'

# Code maker logic
class CodeMaker
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
