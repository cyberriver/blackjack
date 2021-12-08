module GameMethods
  def self.included(base)
    base.extend(ClassMethods)
    base.send :include, InstanceMethods
  end
  module ClassMethods
  end
  module InstanceMethods
    PLAYER_MOVE ="============Ход Игрока================="
    DEALER_MOVE ="============Ход Дилера================="
    MENU ="
    1 - Пропустить
    2 - Добавить карту (если не более 2х карт)
    3 - Открыть карты
    "

    private
    def player_move
      puts PLAYER_MOVE
      puts MENU
      case gets.chomp.to_i
        when 1 then self.wait(@player.user_name,:dealer)
        when 2 then self.take_card
        when 3 then self.reveal_cards
        else raise "вы ввели что-то не то"
        end
    rescue StandardError =>err
        puts err.inspect
        retry
    end

    def take_card
      @player.get_card(@desk)
      self.check_scores
      @moves.push(:dealer)
      @player.show_cards
      if @player.check_cards_limit
        self.reveal_cards
      end
    end

    def reveal_cards
      @dealer.show_cards(:open)
      self.calculate_scores
      puts "Очки дилера:#{@dealer.score}, Очки игрока:#{@player.score} "
      if   @player.score > @dealer.score
        @end_game=:player
      elsif @player.score == @dealer.count_score
        @end_game = :equal
      else @end_game = :dealer
      end
    end

    def calculate_scores
      @dealer.count_score
      @player.count_score
    end

    def dealer_move
      puts DEALER_MOVE
      if @dealer.score.to_i < 17
        @dealer.get_card(@desk)
        @dealer.count_score
        @moves.push(:player)

      elsif @dealer.score.to_i > 21
        puts "Дилер проиграл"
      else
        self.wait(@dealer.user_name,:player)
      end
      if @dealer.check_cards_limit
        self.reveal_cards
      end
    end

    def check_scores
      if @dealer.count_score.to_i>21
        @end_game=:player
      else @player.count_score.to_i>21
        @end_game=:dealer
      end
    end
  end
end
