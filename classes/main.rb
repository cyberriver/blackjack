# frozen_string_literal: true

# interface class
require_relative 'game'
require_relative './modules/display_methods'

class Main
  include DisplayMethods::InstanceMethods
  SUIT = ["\u2662", "\u2664", "\u2665", "\u2667"].freeze
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
  PLAYER_MOVE = " ============Ход Игрока=================
  "
  DEALER_MOVE = " ============Ход Дилера=================
  "
  PLAYER_MENU = "
  1 - Пропустить
  2 - Добавить карту (если не более 2х карт)
  3 - Открыть карты
  "

  def initialize
    @name = ''
  end

  def begin_game
    show_intro
    start
  end

  def start
    show_start
    puts START
    @game.start_game
    puts BET
    @game.game_bet
    show_bet
    show_cards
    begin
      @game.check_endgame
      show_move
      show_cards
      option = gets.chomp.to_i if @game.moves.last == :player
      @game.make_move(option)
    rescue StandardError => e
      puts e.message
      retry
    end
    show_results
    show_victory
    show_cards
    show_ending
  end

  private

  def show_intro
    puts "Вас приветствует игра БлекДжек #{SUIT}"
    print 'пжл-та введите имя игрокa '
    @name = gets.chomp
    @game = Game.new(@name)
    puts "Игрок #{@game.player.user_name} вступил в игру"
  end

  def show_ending
    puts MENU_FINAL
    case gets.chomp.to_i
    when 1 then start
    when 2 then exit
    else raise 'Вы ввели некорректную команду'
    end
  rescue StandardError => e
    e.message
    retry
  end

  def show_move
    print "Ход #{@game.moves.length}"
    if @game.moves.last == :player
      puts PLAYER_MOVE
      puts PLAYER_MENU
    else
      puts DEALER_MOVE
    end
  end

  def show_results
    puts "На счету:#{@game.player.user_name}:#{@game.player.account} #{@game.dealer.user_name}: #{@game.dealer.account}"
    puts "Очки #{@game.player.user_name} - #{@game.player.score}"
    puts END_GAME
    puts "Очки дилера:#{@game.dealer.score}, Очки игрока:#{@game.player.score} "
  end
end
