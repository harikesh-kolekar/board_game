require "board_games/version"
require_relative './board_games/game'
class BoardGame
  def self.play
    puts 'Enter number of player 3-5'
    player_number = 0
    loop do
      player_number = gets.chomp.to_i
      break if (3..5).include?(player_number)

      puts 'Please Enter number of player between 3-5'
    end
    Game.new(player_number).play
  end
end
