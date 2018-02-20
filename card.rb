class Card
  attr_reader :name
  attr_accessor :value

  def initialize(name, value)
    @name = name
    @value = value
  end
end
