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

    def show_cards(par = :close)
      if @user_type == :gamer
        @cards.each { |card| print " #{card.suit} #{card.value} " }
      elsif par == :open && @user_type == :dealer
        @cards.each { |card| print " #{card.suit} #{card.value} " }
      else
        @cards.each { |_card| print " |\u2606 | " }
      end
      puts "<-------карты #{@user_name}"
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

    def check_cards_limit
      @cards.length == 3
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
        @cards << cards[rand(cards.length)]
        cards.delete_at(key)
      end
    end
  end
end
