module Logic
  def preparation
    begin
      raise ArgumentError, 'Your bet is largest your balance!' unless user.money?
    rescue ArgumentError => e
      #abort e.message
      p e.message
      exit
    end
    reset_vars
    bets
  end

  def taking_bet
    begin
      @bank = user.bet(make_bet)
    rescue ArgumentError => e
      p e.message
      retry
    end
    bets
  end

  def first_surrender
    2.times do
      user.put_card(take_card)
      @user_points = include_aces?(user)
      puts_cards(user)
      dealer.put_card(take_card)
      @dealer_points = include_aces?(dealer)
      puts_cards(dealer)
    end
  end

  def user_surrender
    loop do
      choise = ask_card
      break if choise == 0
      if choise == 1
        user.put_card(take_card)
        @user_points = include_aces?(user)
        puts_cards(user)
      end
      break if @user_points > 21
    end
  end

  def dealer_surrender
    loop do
      break if @dealer_points > @user_points || @user_points > 21 || @dealer_points > 20
      dealer.put_card(take_card)
      @dealer_points = include_aces?(dealer)
      puts_cards(dealer)
    end
  end

  def surrender
    first_surrender
    user_surrender
    dealer_surrender
  end

  private

  def reset_vars
    @user_points = 0
    @dealer_points = 0
    @bank = 0
    user.remove_cards
    dealer.remove_cards
    @deck = Deck.new
  end

  def shuffle_deck
    shuffling
    deck.shuffle
  end

  def take_card
    @deck.take_card
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

  def count_bank(bank)
    @bank = if user_points > 21
              0
            elsif user_points == dealer_points
              user.deposit(bank)
            elsif user_points == 21
              user.deposit((bank * 2.5).to_i)
            elsif user_points > dealer_points || dealer_points > 21
              user.deposit((bank * 2).to_i)
            else
              0
            end
    payout
  end
end
