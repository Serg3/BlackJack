require_relative 'controller'
require_relative 'card'
require_relative 'deck'
require_relative 'person'
require_relative 'user'
require_relative 'dealer'
require_relative 'menu'

Controller.new.game

#game.deck.each { |card| p "#{card.name}: #{card.value}" }

#at_exit { p 'Good bye!' }

p 'Good bye!'
