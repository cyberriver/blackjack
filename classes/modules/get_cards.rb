module CardsOperations
  def self.included(base)
    base.extend(ClassMethods)
    base.send :include, InstanceMethods
  end
  module ClassMethods
    def show_cards
      return 1
    end
  end
  module InstanceMethods
    def start(desk)
      #выдать 2 случайные карты из колоды.
      random_select(desk.cards,2)
    #  puts "#{@user_name} выдана карта #{@cards.last.suit} #{@cards.last.value}"
    #  random_select(desk.cards,1)
    #  puts "#{@user_name} выдана карта #{@cards.last.suit} #{@cards.last.value}"
    end

    def show_cards
      if @user_type ==:gamer
        @cards.each {|card| print " #{card.suit} #{card.value} "}
        puts "<-------карты #{@user_name}"
      else
        @cards.each {|card| print " |\u2606 | "}
        puts "<-------карты #{@user_name}"
      end
    end

    def count_score
      score = 0
      @cards.each do |card|
        score +=card.nomimal_score
      end
      puts "Очки #{@user_name} - #{score}"
    #  end
    end

    private

    def random_select(cards, n)
      n.times do
        k=rand(cards.length)
        @cards << cards[rand(cards.length)]
        cards.delete_at(k)
      end
    end

  end
end
