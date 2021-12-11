# frozen_string_literal: true

class Card
  attr_reader :nominal, :value, :face, :suit

  def initialize(suit, nominal, value)
    @suit = suit # масть
    @face = "|\u2606 |" # рубашка
    @nominal = nominal.to_i # номинал очков за карту
    @value = value # значение
  end
end
