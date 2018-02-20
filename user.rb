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
    return true if money > 0
    false
  end

  private

  def widthdraw(value)
    if value <= money
      @money -= value
    else
      raise ArgumentError, 'Your bet is largest your balance!'
    end
  end
end
