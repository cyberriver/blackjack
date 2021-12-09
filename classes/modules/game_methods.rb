module GameMethods
  def self.included(base)
    base.extend(ClassMethods)
    base.send :include, InstanceMethods
  end
  module ClassMethods
  end
  module InstanceMethods
    PLAYER_MOVE ="
    ============Ход Игрока=================
    "
    DEALER_MOVE ="
    ============Ход Дилера=================
    "
    MENU ="
    1 - Пропустить
    2 - Добавить карту (если не более 2х карт)
    3 - Открыть карты
    "
    private
    def player_move
      puts PLAYER_MOVE
      @player.show_cards
      if @player.check_cards_limit
        self.reveal_cards
      else
        puts MENU
        puts "Очки #{@player.user_name} - #{@player.score}"
        case gets.chomp.to_i
          when 1 then self.wait(@player.user_name,:dealer)
          when 2 then self.take_card
          when 3 then self.reveal_cards
        else raise "вы ввели что-то не то"
        end
      end
    rescue StandardError =>err
        puts err.inspect
        retry
    end

    def take_card
      @player.get_card(@desk)
      @player.show_cards
      @moves.push(:dealer)
    end

    def reveal_cards
      puts "Открываем карты"
      @dealer.show_cards(:open)
      @player.show_cards
      self.calculate_scores
      self.check_scores
    end

    def calculate_scores
      @dealer.count_score
      @player.count_score
    end

    def dealer_move
      puts DEALER_MOVE
      if @dealer.check_cards_limit
        self.reveal_cards
      else
      @dealer.show_cards
      self.make_dealer_descision
      end
    end

    def check_scores
      if @dealer.score.to_i>21
        @end_game=:player
      elsif @player.score.to_i>21
        @end_game=:dealer
      elsif
        @player.score >@dealer.score
        @end_game =:player
      else
        @end_game =:equal
      end
    end

    def money_transfer(who_win)
      if who_win==:equal
        @player.account+=@bank/2
        @dealer.account+=@bank/2
      else
        self.instance_variable_get("@#{who_win}").send("account=",@bank+self.instance_variable_get("@#{who_win}").send("account"))
        @bank=0
      end
    end
    def make_dealer_descision
      if @dealer.count_score < 17
        @dealer.get_card(@desk)
        self.reveal_cards
      else
        self.wait(@dealer.user_name,:player)
      end
    end
  end
end
