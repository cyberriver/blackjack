require_relative 'user'

class Dealer < UserGame
  def initialize(name=:Dealer_Blackjack)
    super
    @user_type=:dealer
  end
end
