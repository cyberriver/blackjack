require_relative 'card_desk'
require_relative 'gamer'
require_relative 'dealer'
require_relative './modules/game_methods'

class Main
  include GameMethods::InstanceMethods
  START = "============начало игры============"
  BET = "============Ставка================="
  MENU_FINAL ="
  Игра окончена.
  Хотите сыграть снова?
  1 - Да
  2 - Нет (выйти)
  "


  def initialize
    print "введите имя игрокa "
    @player = Gamer.new(gets.chomp)
    @dealer = Dealer.new
    @desk = CardsDesk.new
    @moves=[]
    @end_game = 0
    puts "Игрок #{@player.user_name} вступил в игру"
    puts "карт в колоде #{@desk.desk_count}"
  end

  def start_game
    puts START
    @end_game = 0
    @player.cards=[]
    @player.score = 0
    @player.start(@desk)
    @player.show_cards
    @dealer.cards=[]
    @dealer.score = 0
    @dealer.start(@desk)
    @dealer.show_cards
    puts "карт в колоде #{@desk.desk_count}"
    puts "На счету:#{@player.user_name}:#{@player.account} #{@dealer.user_name}: #{@dealer.account}"
    @player.count_score
    @dealer.count_score
    puts "Очки #{@player.user_name} - #{@player.score}"
    @bank=0
    @moves.push(:player)
    self.player_make_bet
    self.choose_move
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

  def choose_move
    loop do
      if @moves.last ==:player
        then self.player_move
      else self.dealer_move
      end
      break if [:player,:equal,:dealer].include?(@end_game)
    end
    self.display_victory
    self.choose_game
  end

  def choose_game
    puts MENU_FINAL
    loop do
      case gets.chomp.to_i
      when 1 then self.start_game
      when 2 then break
      else puts "Вы ввели некорректную команду choose_game"
      end
    end
  end

  private

  def wait(name,move)
    puts "Пропуск хода #{name}"
    @moves.push(move)
  end

  def display_victory
    if @end_game==:player
      puts "Игрок #{@player.user_name} победил"
    elsif @end_game==:equal
      puts "Ничья"
    else
      puts "Дилер #{@dealer.user_name} победил"
    end
  end
end
