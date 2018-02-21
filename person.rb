class Person
  attr_accessor :points
  attr_reader :name, :money, :cards

  def initialize(name)
    @name = name
    @cards = []
    @points = 0
  end

  def put_card(card)
    cards << card
  end

  def remove_cards
    @cards = []
  end
end
