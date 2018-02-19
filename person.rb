class Person
  attr_accessor :cards
  attr_reader :name, :money

  def initialize(name)
    @name = name
    @cards = []
  end
end
