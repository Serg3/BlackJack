class User < Person
  def initialize(name)
    super
    @money = 100
  end

  def bet(value)
    widthdraw(value)
    value
  end

  private

  def widthdraw(value)
    @money -= value
  end
end
