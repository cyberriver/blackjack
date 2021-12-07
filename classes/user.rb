require_relative './modules/get_cards'

class UserGame
  extend CardsOperations::ClassMethods
  include CardsOperations::InstanceMethods
  attr_accessor :user_type, :bet, :user_name, :account, :cards, :card_score

  def initialize(user_name)
    @user_type = :meta
    @account = 100 #USD
    @user_name = user_name.to_s
    @cards = []
    @cards_score = 0
    @bet=0
  end

  def make_a_bet
    @bet=10
    @account -=@bet
    raise "у #{@user_name} закончились деньги" unless @account >0
  end

end
