# frozen_string_literal: true

require_relative 'card_desk'
require_relative 'gamer'
require_relative 'dealer'
require_relative './modules/game_methods'

class Main
  include GameMethods::InstanceMethods
  START = "
  ============начало игры============
  "
  BET = "
  ============Ставка=================
  "
  MENU_FINAL = "
  Игра окончена.
  Хотите сыграть снова?
  1 - Да
  2 - Нет (выйти)
  "
  END_GAME = "
  =============ИТОГИ ПАРТИИ ==========
  "

  def initialize
    puts "Вас приветствует игра БлекДжек #{$SUIT}"
    print 'пжл-та введите имя игрокa '
    @player = Gamer.new(gets.chomp)
    @dealer = Dealer.new
    @desk = CardsDesk.new
    @moves = []
    @end_game = 0
    puts "Игрок #{@player.user_name} вступил в игру"
    puts "карт в колоде #{@desk.desk_count}"
  end

  def start_game
    puts START
    reset
    puts "На счету:#{@player.user_name}:#{@player.account} #{@dealer.user_name}: #{@dealer.account}"
    puts "Очки #{@player.user_name} - #{@player.score}"
    @moves.push(:player)
    game_bet if check_dealer
    choose_move
  end

  def game_bet
    puts BET
    @player.make_a_bet
    @dealer.make_a_bet
    @bank += (@player.bet + @dealer.bet)
    puts "Ставки сделаны=>#{@player.user_name}:#{@player.bet} #{@dealer.user_name}: #{@dealer.bet}"
    puts "В банке #{@bank}"
    puts "На счету:#{@player.user_name}:#{@player.account} #{@dealer.user_name}: #{@dealer.account}"
  rescue StandardError => e
    e.inspect
  end

  def choose_move
    loop do
      if @moves.last == :player
        then player_move
      else
        dealer_move
      end
      break if %i[player equal dealer].include?(@end_game)
    end
    display_victory
    choose_game
  end

  def choose_game
    puts MENU_FINAL
    case gets.chomp.to_i
    when 1 then start_game
    when 2 then exit
    else raise 'Вы ввели некорректную команду choose_game'
    end
  rescue StandardError => e
    e.inspect
    retry
  end

  private

  def wait(name, move)
    puts "Пропуск хода #{name}"
    @moves.push(move)
  end

  def reset
    @end_game = 0
    @bank = 0
    @player.cards = []
    @player.score = 0
    @player.start(@desk)
    @player.show_cards
    @dealer.cards = []
    @dealer.score = 0
    @dealer.start(@desk)
    @dealer.show_cards
    @player.count_score
    @dealer.count_score
  end

  def display_victory
    puts END_GAME
    puts "Очки дилера:#{@dealer.score}, Очки игрока:#{@player.score} "
    case @end_game
    when :player
      puts "\u2606 \u2606 Игрок #{@player.user_name} победил \u2606 \u2606"
    when :equal
      puts 'Ничья'
    else
      puts "¯ \ _ (ツ) _ / ¯ Дилер #{@dealer.user_name} победил"
    end
    money_transfer(@end_game)
    puts "На счету:#{@player.user_name}:#{@player.account} #{@dealer.user_name}: #{@dealer.account}"
  end

  def check_dealer
    if @dealer.account.positive?
      true
    else
      return false
      puts 'У диллера закончились деньги :('
      exit
    end
  end
end
