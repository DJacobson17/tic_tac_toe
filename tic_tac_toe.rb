# frozen_string_literal: true
require 'pry-byebug'

class Player # rubocop:disable Style/Documentation
  attr_accessor :name, :marker, :score

  def initialize(player_number)
    give_name(player_number)
    give_marker(player_number)
    @score = 0
  end
  @@other_marker = '' # rubocop:disable Style/ClassVars

  private

  def give_name(player_number)
    puts "Welcome to the game player #{player_number} what's your name?"
    @name = gets.chomp.upcase
  end

  def give_marker(player_number)
    validate_marker = false
    until validate_marker
      puts 'Please choose a letter to represnt you.'
      puts "It cannot be #{@@other_marker}." if @@other_marker != ''
      @marker = gets.chomp.upcase
      if @marker =~ /^[A-Z]\b/ && @marker != @@other_marker
        @@other_marker = @marker
        validate_marker = true
      else
        puts 'Invalid selection.  Please choose again.'
      end
    end
  end
end

class Game # rubocop:disable Style/Documentation
  attr_accessor :game_over, :available, :display
  def initialize(p1, p2)
    @p1 = p1
    @p2 = p2
    @display = %w[1 2 3 4 5 6 7 8 9]
    @game_over = false
    display_board
  end

  def decorative_row
    puts ' - + - + - '
  end

  def row1
    puts " #{@display[0]} | #{@display[1]} | #{@display[2]} "
  end

  def row2
    puts " #{@display[3]} | #{@display[4]} | #{@display[5]} "
  end

  def row3
    puts " #{@display[6]} | #{@display[7]} | #{@display[8]} "
  end

  def display_board
    row1
    decorative_row
    row2
    decorative_row
    row3
  end
end

p1 = Player.new(1)
p2 = Player.new(2)
puts "Hi #{p1.name} and #{p2.name}!"
tictactoe = Game.new(p1, p2)


