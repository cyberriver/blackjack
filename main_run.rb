$LOAD_PATH << '.'
require './classes/main'
game = Main.new()
game.start_game
game.player_make_bet
game.player_move
