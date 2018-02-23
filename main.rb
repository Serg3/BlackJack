require_relative 'controller'
require_relative 'card'
require_relative 'deck'
require_relative 'person'
require_relative 'user'
require_relative 'menu'
require_relative 'logic'
require_relative 'game_play'

Controller.new(Menu.new, Logic.new).start

p 'Good bye!'
