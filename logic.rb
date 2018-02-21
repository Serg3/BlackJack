module Logic
  private

  # preparation

  def preparation
    check_money
    reset_vars
    bets
  end

  def check_money
    raise ArgumentError, 'You have no money!' unless user.money?
  rescue ArgumentError => e
    abort e.message
  end

  def reset_vars
    user.points = 0
    dealer.points = 0
    @bank = 0
    user.remove_cards
    dealer.remove_cards
    @deck = Deck.new
  end

  # taking_bet

  def taking_bet
    begin
      @bank = user.bet(make_bet)
    rescue ArgumentError => e
      p e.message
      retry
    end
    bets
  end

  # shuffle_deck

  def shuffle_deck
    shuffling
    deck.shuffle
  end

  # surrender

  def surrender
    first_surrender
    user_surrender
    dealer_surrender
  end

  def first_surrender
    2.times do
      cards_points(user)
      cards_points(dealer)
    end
  end

  def user_surrender
    loop do
      choise = ask_card
      break if choise == 0
      cards_points(user) if choise == 1
      break if user.points > 21
    end
  end

  def dealer_surrender
    loop do
      break if dealer.points > user.points || user.points > 21 || dealer.points > 20
      cards_points(dealer)
    end
  end

  def cards_points(person)
    person.put_card(take_card)
    person.points = include_aces?(person)
    puts_cards(person)
  end

  def take_card
    @deck.take_card
  end

  def include_aces?(person)
    points = count_points(person)
    aces = person.cards.select { |card| card.value == 11 }
    if aces.size == 1 && points > 21
      change_value(person, aces)
      return count_points(person)
    elsif aces.size > 1
      change_value(person, aces)
      return count_points(person)
    end
    points
  end

  def count_points(person)
    total = 0
    person.cards.each do |card|
      total += card.value
    end
    total
  end

  def change_value(person, aces)
    puts_cards(person)
    aces.first.value = 1
  end

  # payout

  def payout
    @bank = if user.points > 21
              0
            elsif user.points == dealer.points
              user.deposit(bank)
            elsif user.points == 21
              user.deposit((bank * 2.5).to_i)
            elsif user.points > dealer.points || dealer.points > 21
              user.deposit((bank * 2).to_i)
            else
              0
            end
    puts_payout
  end
end
