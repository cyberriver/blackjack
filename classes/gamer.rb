# frozen_string_literal: true

require_relative 'user'

class Gamer < UserGame
  def initialize(name)
    super
    @user_type = :gamer
  end
end
