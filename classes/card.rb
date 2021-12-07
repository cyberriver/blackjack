class Card
  attr_reader :suit, :nomimal_score, :value
  def initialize(suit,nominal,value)
    @suit=suit #масть
    @nomimal_score=nominal #номинал очков за карту
    @value = value #значение
  end
end
