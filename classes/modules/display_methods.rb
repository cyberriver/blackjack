module DisplayMethods
  def self.included(base)

    base.send :include, InstanceMethods
  end

  module ClassMethods
  end

  module InstanceMethods
    private

      def show_start
        puts "Игрок #{@game.player.user_name} вступил в игру"
      end

      def show_bet
        puts "Ставки сделаны=>#{@game.player.user_name}:#{@game.player.bet} #{@game.dealer.user_name}: #{@game.dealer.bet}"
        puts "В банке #{@game.bank}"
        puts "На счету:#{@game.player.user_name}:#{@game.player.account} #{@game.dealer.user_name}: #{@game.dealer.account}"
      end


      def show_victory
        case @game.victory
        when :player
          puts "\u2606 \u2606 Игрок #{@game.player.user_name} победил \u2606 \u2606"
        when :equal
          puts 'Ничья'
        when :dealer
          puts "¯ \ _ (ツ) _ / ¯ Дилер #{@game.dealer.user_name} победил"
        end
        puts "На счету:#{@game.player.user_name}:#{@game.player.account} #{@game.dealer.user_name}: #{@game.dealer.account}"
      end

       def show_cards
         @game.player.cards.each { |card| print " #{card.suit} #{card.value} " }
         puts "<-------карты #{@game.player.user_name}"

         if @game.victory == 0
           @game.dealer.cards.each { |card| print " #{card.face} " }
         else
         @game.dealer.cards.each { |card| print " #{card.suit} #{card.value} " }
        end

        puts "<-------карты #{@game.dealer.user_name}"
       end
  end
end
