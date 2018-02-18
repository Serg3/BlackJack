require_relative 'controller'
require_relative 'card'
require_relative 'deck'

game = Controller.new

game.deck.each { |card| p "#{card.name}: #{card.value}" }
