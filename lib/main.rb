# frozen_string_literal: true

require_relative 'tic_tac_toe'
require_relative 'player'

p1 = Player.new(1)
p2 = Player.new(2)
puts "Hi #{p1.name} and #{p2.name}!"
Game.new(p1, p2)
