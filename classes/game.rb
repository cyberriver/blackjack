# frozen_string_literal: true

require_relative 'card_desk'
require_relative 'gamer'
require_relative 'dealer'
require_relative './modules/game_methods'

class Game
  attr_accessor :player, :dealer, :desk, :moves, :end_game, :bank
  attr_reader :victory
  include GameMethods::InstanceMethods
  def initialize( name = 'Player')
    @player = Gamer.new(name)
    @dealer = Dealer.new
    @desk = CardsDesk.new
    @moves = []
    @end_game = false
    @victory = 0
  end

  def start_game
    reset
  end

  def game_bet
    if self.check_dealer
     @player.make_a_bet
     @dealer.make_a_bet
     @bank = @player.bet + @dealer.bet
   else
     raise "У дилера закончились деньги. Вы победили"
   end
  end

  def check_endgame
    if @player.cards.length == 3 && @dealer.cards.length==3
      @end_game = true
    elsif @player.cards.length == 3 && @dealer.cards.length<3 && @moves.include?(:dealer)
      @end_game = false
    end
  end

  def make_move(option)
    self.send("#{@moves.last.to_s}_move",option) if @end_game
    self.reveal_cards if @end_game
    self.money_transfer(@victory) if @end_game
  end

  private

  def wait(name, move)
    @moves.push(move)
    raise "Пропуск хода #{name}"
  end

  def reset
    @victory = 0
    @end_game=0
    @moves = []
    @moves.push(:player)
    @bank = 0
    @player.cards = []
    @player.score = 0
    @player.start(@desk)
    @dealer.cards = []
    @dealer.score = 0
    @dealer.start(@desk)
    @player.count_score
    @dealer.count_score
  end

  def check_dealer
    if @dealer.account.positive?
      true
    else
      return false
      @victory=:player
    end
  end

  def money_transfer(who_win)
    if who_win == :equal
      @player.account += @bank / 2
      @dealer.account += @bank / 2
    else
      instance_variable_get("@#{who_win}").send('account=',
                                                @bank + instance_variable_get("@#{who_win}").send('account'))
      @bank = 0
    end
  end
end
