class Person
  attr_reader :name, :money, :cards

  def initialize(name)
    @name = name
    @cards = []
  end

  def put_card(card)
    cards << card
  end

  def remove_cards
    @cards = []
  end
end
