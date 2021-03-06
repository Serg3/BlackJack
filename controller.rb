require_relative 'logic'

class Controller
  attr_reader :user, :dealer, :menu, :logic, :game_play

  def initialize(menu, logic)
    @game_play = ''
    @menu = menu
    @logic = logic

    @user = ''
    @dealer = Person.new('Dealer')
  end

  def start
    @user = User.new(menu.ask_name)
    menu.greeting(user.name)
    game
  end

  private

  def game
    game_play = GamePlay.new(menu, logic, user, dealer)
    game_play.preparation
    game_play.taking_bet

    game_play.shuffle_deck
    game_play.deal_cards

    menu.puts_payout(game_play.payout)
    game if menu.continue?
  end
end
