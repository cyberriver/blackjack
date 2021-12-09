# frozen_string_literal: true

require_relative 'user'

class Gamer < UserGame
  def initialize(name = 'Player')
    super
    @user_type = :gamer
  end
end
