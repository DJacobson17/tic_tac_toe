# frozen_string_literal: true

require 'pry-byebug'
require 'colorize'

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

  def give_marker(_player_number)
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
  attr_reader :win_combos

  def initialize(p1, p2) # rubocop:disable Naming/MethodParameterName
    @p1 = p1
    @p2 = p2
    @display = %w[1 2 3 4 5 6 7 8 9]
    @available = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @game_over = false
    play_game
  end

  private

  def play_game
    player = @p1
    until game_over == true
      display_board
      puts "#{player.name} where would you like to go?"
      selection = gets.chomp.to_i
      next unless available.include?(selection)

      available.delete(selection)
      display[selection - 1] = player.marker
      check_win(player)
      check_draw
      player = player == @p1 ? @p2 : @p1
    end
    restart
  end

  def check_win(player)
    # binding.pry
    win_combos = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    win_combos.each do |combo|
      arr = []
      combo.each do |i|
        arr << @display[i]
      end
      next unless arr.all?(player.marker)

      puts "#{player.name} is the winner!"
      display_board
      player.score += 1
      @game_over = true
    end

    def check_draw
      if available.empty?
        puts "It's a draw."
        @game_over = true
      end
    end

    def restart
      puts 'Play again?'
      replay = gets.chomp.upcase
      if replay == 'Y'
        Game.new(@p1, @p2)
      else
        display_board
        puts 'Thanks for playing!'
      end
    end
  end

  def decorative_row
    puts ' - + - + -'
  end

  def row1
    puts " #{@display[0]} | #{@display[1]} | #{@display[2]}           #{@p1.name}    Score: #{@p1.score}"
  end

  def row2
    puts " #{@display[3]} | #{@display[4]} | #{@display[5]}           #{@p2.name}    Score: #{@p2.score}"
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
tictactoe = Game.new(p1, p2) # rubocop:disable Lint/UselessAssignment
