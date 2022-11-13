# frozen_string_literal: true

require 'pry-byebug'
require_relative 'player'


class Game # rubocop:disable Style/Documentation
  attr_accessor :game_over, :available, :display
  attr_reader :win_combos

  def initialize(p1 = 'dave', p2 = 'erin', display = %w[1 2 3 4 5 6 7 8 9]) # rubocop:disable Naming/MethodParameterName
    @p1 = p1
    @p2 = p2
    @display = display
    @available = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @game_over = false
    # play_game
  end

  # private

  def play_game
    player = @p2
    until @game_over == true
      player = player == @p1 ? @p2 : @p1
      display_board
      player_turn(player)
      @game_over = check_win(player)
    end
    display_winner(player)
    restart
  end

  def player_turn(player)
    selection = player_input(player)
    @available.delete(selection)
    @display[selection - 1] = player.marker
  end

  def player_input(player)  
    loop do 
      puts "#{player.name} where would you like to go? Or type 'q' to quit."
      selection = gets.chomp
      if selection == 'q'
        puts "Thanks for playing"
        exit
      end
      return selection.to_i if verify_selection(selection)
    end
  end

  def verify_selection(selection)
    @available.include?(selection.to_i) 
  end

  def check_win(player)
    win_combos = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    win_combos.each do |combo|
      arr = []
      combo.each do |i|
        arr << @display[i]
      end
      next unless arr.all?(player.marker)

      return true
    end
    check_draw ? true : false
  end

  def display_winner(player)
    if available.empty?
      puts 'Tie game!'
    else
      puts "#{player.name} is the winner!"
      display_board
      player.score += 1
    end
  end

  def check_draw
    true if available.empty?
  end

  def restart
    puts 'Play again?'
    replay = gets.chomp.upcase
    if replay == 'Y'
      Game.new(@p1, @p2).play_game
    else
      display_board
      puts 'Thanks for playing!'
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
