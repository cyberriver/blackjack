# frozen_string_literal: true

class Card
  attr_reader :suit, :nominal, :value

  def initialize(suit, nominal, value)
    @suit = suit # масть
    @nominal = nominal.to_i # номинал очков за карту
    @value = value # значение
  end
end
