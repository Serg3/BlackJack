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
    reset_vars
    return unless balance?
    bets(bank)
    begin
      bank = user.bet(make_bet)
    rescue ArgumentError => e
      p e.message
      game
    end
    bets(bank)

    deck.shuffle
    2.times do
      @user_points = deck.take_card(user)
      @dealer_points = deck.take_card(dealer)
    end

    loop do
      choise = choose_action
      break if choise == 0
      @user_points = deck.take_card(user) if choise == 1
      break if @user_points > 21
    end

    loop do
      break if @dealer_points > @user_points || @user_points > 21 || @dealer_points > 19
      @dealer_points = deck.take_card(dealer)
    end

    payout(bank)
    game if continue?
  end

  private

  attr_accessor :user_points, :dealer_points

  def reset_vars
    @user_points = 0
    @dealer_points = 0
    user.cards = []
    dealer.cards = []
    @deck = Deck.new
  end

  def balance?
    if user.money?
      true
    else
      p 'Not enough monye!'
      false
    end
  end

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

  def payout(bank)
    if user_points > 21
      p "Bank: 0"
    elsif user_points == dealer_points
      p "Bank: #{user.deposit(bank)}"
    elsif user_points == 21
      p "Bank: #{user.deposit((bank * 2.5).to_i)}"
    elsif user_points > dealer_points || dealer_points > 21
      p "Bank: #{user.deposit((bank * 2).to_i)}"
    else
      p "Bank: 0"
    end
  end
end
