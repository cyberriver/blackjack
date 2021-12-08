module DealerMove
  def self.included(base)
    base.extend(ClassMethods)
    base.send :include, InstanceMethods
  end
  module ClassMethods
  end
  module InstanceMethods
    DEALER_MOVE ="============Ход Дилера================="
    private
    def dealer_move
      puts DEALER_MOVE
      #logic move
      puts "log:#{@dealer.score}"
      self.check_scores
      if @dealer.score.to_i < 17
        @dealer.get_card(@desk)
        @dealer.count_score
        @moves.push(:player)
        puts "log: Дилер взял карту #{@dealer.cards.last}"
      elsif @dealer.score.to_i > 21
        puts "Дилер проиграл"
      else
        self.wait(@dealer.user_name,:player)
      end
      if @dealer.check_cards
        self.reveal_cards
      end
    end

    def check_scores
      if @dealer.count_score.to_i>21
        @end_game=:player
      end
    end
  end
end
