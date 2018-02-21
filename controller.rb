require_relative 'menu'
require_relative 'logic'

class Controller
  include Menu
  include Logic

  attr_accessor :deck, :bank
  attr_reader :user, :dealer

  def initialize
    @user = User.new(ask_name)
    greeting(user.name)
    @dealer = Person.new('Dealer')
    @deck = ''
    @bank = 0
  end

  def game
    preparation
    taking_bet

    shuffle_deck
    surrender

    count_bank(bank)
    game if continue?
  end

  private

  attr_accessor :user_points, :dealer_points
end
