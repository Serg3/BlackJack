module Menu
  def ask_name
    print 'Enter your name, please: '
    gets.chomp
  end

  def greeting(name)
    p "Hello, #{name}! Let's play Black Jack!"
  end

  def make_bet
    print 'Please, make your bet: '
    gets.chomp.to_i
  end

  def bets(bank)
    p "Bank: #{bank};  User: #{user.money}"
  end

  def shuffling
    p 'Shuffling...'
    sleep(1)
  end

  def surrender
    p 'Surrender...'
    sleep(1)
  end

  def puts_cards(person)
    sleep(1)
    total = 0
    print "#{person.name}'s cards:"
    person.cards.each do |card|
      print " #{card.name}"
      total += card.value
    end
    p "  Total: #{total}"
  end

  def choose_action
    p '1 - One more card.'
    p '0 - Enough.'
    print 'Please, make your choise: '
    gets.chomp.to_i
  end
end
