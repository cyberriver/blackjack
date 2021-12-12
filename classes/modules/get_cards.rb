# frozen_string_literal: true

module CardsOperations
  def self.included(base)
    base.extend(ClassMethods)
    base.send :include, InstanceMethods
  end

  module ClassMethods
  end

  module InstanceMethods
    def start(desk)
      random_select(desk.cards, 2)
    end

    def get_card(desk)
      random_select(desk.cards, 1)
    end

    def count_score
      @score = 0
      ace = false
      @cards.each do |card|
        if card.suit == 'A'
          @score = score
          ace = true
        else
          @score += card.nominal
        end
        ace_points_calc(ace) if ace
      end
    end

    private

    def ace_points_calc(ace)
      check = @score + 11
      @score += if ace && check > 21
                  1
                else
                  11
                end
    end

    def random_select(cards, num)
      num.times do
        key = rand(cards.length)
        @cards << cards[key]
        cards.delete_at(key)
      end
    end
  end
end
