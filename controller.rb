require_relative 'menu'

class Controller
  include Menu

  attr_accessor :deck, :bank
  attr_reader :user, :dealer

  def initialize
    @user = User.new(ask_name)
    greeting(user.name)
    @dealer = Dealer.new('Dealer')
    @deck = Deck.new
    @bank = 0
  end

  def game
    bank = user.bet(make_bet)
    bets(bank)

    deck.shuffle
    2.times do
      deck.take_card(user)
      deck.take_card(dealer)
    end

    loop do
      choise = choose_action
      break if choise == 0
      deck.take_card(user) if choise == 1
    end

  end
end
