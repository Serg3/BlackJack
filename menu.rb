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
    #sleep(1)
  end

  def surrender
    p 'Surrender...'
    #sleep(1)
  end
end
