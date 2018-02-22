class User < Person
  def initialize(name)
    super
    @money = 100
  end

  def bet(value)
    widthdraw(value)
    value
  end

  def deposit(value)
    @money += value
    value
  end

  def money?
    money > 0
  end

  private

  def widthdraw(value)
    raise ArgumentError, 'Your bet is largest your balance!' if value > money
    @money -= value
  end
end
