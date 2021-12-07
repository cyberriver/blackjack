require_relative 'card_desk'
require_relative 'gamer'
require_relative 'dealer'

class Main
  START = "============начало игры============"
  BET = "============Ставка================="
  PLAYER_MOVE ="============Ход Игрока================="
  DEALER_MOVE ="============Ход Дилера================="
  MENU ="
  1 - Пропустить
  2 - Добавить карту (если не более 2х карт)
  3 - Открыть карты
  "
  def initialize
    print "введите имя игрокa "
    @player = Gamer.new(gets.chomp)
    @dealer = Dealer.new()
    @desk = CardsDesk.new()
    @moves=[]
    puts "Игрок #{@player.user_name} вступил в игру"
    puts "карт в колоде #{@desk.desk_count}"

  end

  def start_game
    puts START
    @player.start(@desk)
    @dealer.start(@desk)
    @player.show_cards
    @dealer.show_cards
    puts "карт в колоде #{@desk.desk_count}"
    puts "На счету:#{@player.user_name}:#{@player.account} #{@dealer.user_name}: #{@dealer.account}"
    @player.count_score
    @bank=0
    @moves.push(:p)
  end

  def player_make_bet
    puts BET
    @player.make_a_bet
    @dealer.make_a_bet
    @bank +=(@player.bet+@dealer.bet)
    puts "Ставки сделаны=>#{@player.user_name}:#{@player.bet} #{@dealer.user_name}: #{@dealer.bet}"
    puts "В банке #{@bank}"
    puts "На счету:#{@player.user_name}:#{@player.account} #{@dealer.user_name}: #{@dealer.account}"
  end

  def player_move
    puts PLAYER_MOVE
    puts MENU
    loop do
      case gets.chomp.to_i
      when 1 then self.wait
      when 2 then self.take_card
      when 3 then self.show_cards
      else raise "вы ввели что-то не то"
      end
    rescue StandardError =>err
      puts err.inspect
      retry
    end
  end

  private
  def wait
    puts "wait"
  end

  def take_card
    puts "take_card"
  end

  def show_cards
    puts "show_cards"
  end
end
