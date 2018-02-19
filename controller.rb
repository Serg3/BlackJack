require_relative 'menu'

class Controller
  include Menu

  attr_accessor :deck, :bank
  attr_reader :user, :dealer

  def initialize
    @user = User.new(ask_name)
    greeting(user.name)
    @dealer = Dealer.new('Dealer')
    @deck = ''
    @bank = 0
  end

  def game
    user_points = 0
    dealer_points = 0
    user.cards = []
    dealer.cards = []
    deck = Deck.new

    bank = user.bet(make_bet)
    bets(bank)

    deck.shuffle
    2.times do
      user_points = deck.take_card(user)
      dealer_points = deck.take_card(dealer)
    end

    loop do
      choise = choose_action
      break if choise == 0
      user_points = deck.take_card(user) if choise == 1
      break if user_points > 21
    end

    loop do
      break if dealer_points > user_points || user_points > 21
      dealer_points = deck.take_card(dealer)
    end

    game if continue?
  end

  private

  def choose_action
    p '1 - One more card.'
    p '0 - Enough.'
    print 'Please, make your choise: '
    gets.chomp.to_i
  end

  def continue?
    p 'Do you want to continue the game?'
    p '1 - Yes!'
    p '0 - No.'
    print 'Please, make your choise: '
    return true if gets.chomp.to_i == 1
    false
  end
end
