require_relative 'logic'

class Controller
  include Logic

  attr_accessor :deck, :bank
  attr_reader :user, :dealer

  def initialize
    @user = User.new(ask_name)
    greeting
    @dealer = Person.new('Dealer')
    @deck = ''
    @bank = 0
  end

  def game
    preparation
    taking_bet

    shuffle_deck
    deal_cards

    payout
    game if continue?
  end

  private

  attr_accessor :user_points, :dealer_points
end
