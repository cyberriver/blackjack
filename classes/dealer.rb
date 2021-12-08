require_relative 'user'

class Dealer < UserGame
  def initialize(name=:Казино_рояль)
    super
    @user_type=:dealer
  end
end
