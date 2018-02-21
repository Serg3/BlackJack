module Logic
  def preparation
    raise ArgumentError, 'Your bet is largest your balance!' unless user.money?
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
      choise = choose_action
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

  private

  def reset_vars
    @user_points = 0
    @dealer_points = 0
    @bank = 0
    user.remove_cards
    dealer.remove_cards
    @deck = Deck.new
  end

  def take_card
    @deck.take_card
  end

  def include_aces?(person)
    points = puts_cards(person)
    aces = person.cards.select { |card| card.value == 11 }
    if aces.size == 1 && points > 21
      aces.first.value = 1
      return puts_cards(person)
    elsif aces.size > 1
      aces.first.value = 1
      return puts_cards(person)
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
