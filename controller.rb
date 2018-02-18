class Controller
  attr_accessor :deck

  def initialize
    @deck = Deck.new.deck
  end
end
