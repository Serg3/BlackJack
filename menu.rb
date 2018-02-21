module Menu
  # initialize

  def ask_name
    print 'Enter your name, please: '
    gets.chomp
  end

  def greeting
    p "Hello, #{user.name}! Let's play Black Jack!"
  end

  # preparation

  def bets
    p "Bank: #{bank};  User: #{user.money}"
  end

  # taking_bet

  def make_bet
    print 'Please, make your bet: '
    gets.chomp.to_i
  end

  # shuffle_deck

  def shuffling
    p 'Shuffling...'
  end

  # surrender

  def ask_card
    p '1 - One more card.'
    p '0 - Enough.'
    print 'Please, make your choise: '
    gets.chomp.to_i
  end

  def puts_cards(person)
    print "#{person.name}'s cards:"
    person.cards.each do |card|
      print " #{card.name}"
    end
    p "  Total: #{count_points(person)}"
  end

  # payout

  def puts_payout
    p "Bank for payout: #{bank}"
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
