class GamePlay
  attr_accessor :bank
  attr_reader :menu, :logic, :user, :dealer, :deck

  def initialize(menu, logic, user, dealer)
    @user = user
    @dealer = dealer
    validation_money!
    @menu = menu
    @logic = logic

    @bank = 0
    @deck = Deck.new
    user.points = 0
    user.remove_cards
    dealer.points = 0
    dealer.remove_cards
  end

  def preparation
    menu.show_bets(bank, user.money)
  end

  def taking_bet
    begin
      @bank = user.bet(menu.make_bet)
    rescue ArgumentError => e
      p e.message
      retry
    end
    menu.show_bets(bank, user.money)
  end

  def shuffle_deck
    menu.shuffling
    deck.shuffle
  end

  def deal_cards
    first_deal
    user_get_cards
    dealer_get_cards
  end

  def payout
    logic.count_payout(user, dealer, bank)
  end

  private

  def validation_money!
    raise ArgumentError, 'You have no money!' unless user.money?
  rescue ArgumentError => e
    abort e.message
  end

  def first_deal
    2.times do
      cards_points(user)
      cards_points(dealer)
    end
  end

  def user_get_cards
    loop do
      choise = menu.ask_card
      break if choise == 0
      cards_points(user) if choise == 1
      break if user.points > 21
    end
  end

  def dealer_get_cards
    loop do
      break if dealer.points > user.points || user.points > 21 || dealer.points > 20
      cards_points(dealer)
    end
  end

  def cards_points(person)
    person.get_card(@deck.take_card)
    person.points = logic.conversion_ace_value(person)
    menu.puts_cards(person, logic.count_points(person))
  end
end
