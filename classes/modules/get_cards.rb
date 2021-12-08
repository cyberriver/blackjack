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
      random_select(desk.cards,2)
    end

    def get_card(desk)
      random_select(desk.cards,1)
    end

    def show_cards(par=:close)
      if @user_type ==:gamer
        @cards.each {|card| print " #{card.suit} #{card.value} "}
        puts "<-------карты #{@user_name}"
      elsif par ==:open
        @cards.each {|card| print " #{card.suit} #{card.value} "}
        puts "<-------карты #{@user_name}"
      else
        @cards.each {|card| print " |\u2606 | "}
        puts "<-------карты #{@user_name}"
      end
    end

    def count_score
      @score = 0
      score_calc=0
      @cards.each do |card|
        score_calc+=card.nominal
        if card.suit =="A" && score_calc >21
          @score+=1
        else
          @score = score_calc
        end
      end
      return @score
    end

    def check_cards_limit
      if @cards.length==3
        return true
      else
        return false
      end
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
