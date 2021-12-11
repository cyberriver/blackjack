# frozen_string_literal: true

module GameMethods
  def self.included(base)
    base.extend(ClassMethods)
    base.send :include, InstanceMethods
  end

  module ClassMethods
  end

  module InstanceMethods

    private

    def player_move(option)
        case option.to_i
        when 1 then wait(@player.user_name, :dealer)
        when 2 then self.take_card
        when 3 then self.reveal_cards
        else raise 'вы ввели что-то не то'
        end
    end

    def take_card
      @player.get_card(@desk)
      @moves.push(:dealer)
    end

    def reveal_cards
      calculate_scores
      define_victory
      @end_game=true
    end

    def calculate_scores
      @dealer.count_score
      @player.count_score
    end

    def dealer_move(option)
     self.make_dealer_descision
    end

    def define_victory
      @victory = if @dealer.score.to_i > 21
                    :player
                  elsif @player.score.to_i > 21
                    :dealer
                  elsif @player.score > @dealer.score
                    :player
                  elsif @player.score < @dealer.score
                    :dealer
                  elsif @player.score == @dealer.score
                    :equal
                  end
    end

    def make_dealer_descision
      if @dealer.score < 17
        @dealer.get_card(@desk)
      else
        wait(@dealer.user_name, :player)
      end
    end
  end
end
