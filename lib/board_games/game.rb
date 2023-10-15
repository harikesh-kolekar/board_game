# frozen_string_literal: true

require 'colorize'
require_relative './board'
require 'active_support/core_ext/module/delegation'

# Create Game with number of Player
class Game
  attr_accessor :board, :current_player

  def initialize(number_of_players)
    @board = Board.new(number_of_players)
  end

  delegate :properties, :players, :number_of_players, to: :board

  def play
    current_player_index = 0

    # Game loop
    loop do
      # Display the board after each player's turn
      board.display_board

      # Display the players state
      game_state

      # Play the gane for current_player
      play_for_payer(current_player_index)

      # Move to the next player
      current_player_index = (current_player_index + 1) % players.length
    end
  end

  private

  def play_for_payer(current_player_index)
    @current_player = players[current_player_index]

    roll = menu_option # roll_dice(current_player)

    # Shift player position
    new_square = shift_position(roll)

    # Pay rent
    process_to_pay(new_square, 'rent')
  end

  def menu_option
    loop do
      puts '*' * 100
      puts "#{current_player.name}'s turn.".colorize(:red)
      puts ' - Enter 1 to buy the Squar'
      puts ' - Enter any key to play'
      option = gets.chomp
      # Play the Game
      return roll_dice if option.to_i != 1

      # Buy the Property
      buy_squar
    end
  end

  def buy_squar
    puts 'Enter square number to buy(2-32)'
    loop do
      new_square_number = gets.chomp.to_i
      if (2..32).include?(new_square_number)
        # Buy the square
        process_to_buy(new_square_number - 1)
        break
      end
      puts 'Please Enter Value between(1-32)'
    end
  end

  def process_to_buy(new_square_number)
    new_square = properties[new_square_number]
    # Pay for square
    process_to_pay(new_square, 'value')
    # Shift Property owner
    new_square.owner.delete_property(new_square)
    new_square.owner = current_player
    current_player.add_property(new_square)
  end

  def process_to_pay(new_square, value)
    owner = new_square.owner
    if owner == current_player
      puts "#{current_player.name} is owner of #{new_square.name}"
      return
    end
    pay_amount = new_square.send(value)
    owner.money += pay_amount
    current_player.money -= pay_amount
    puts "#{current_player.name} paid #{pay_amount} to #{owner.name} for #{new_square.name}".colorize(:blue)
  end

  def roll_dice
    puts '*' * 100
    # Simulate rolling six-sided dice
    roll = rand(1..6)
    puts "Rolled #{roll}".colorize(:red)
    roll
  end

  def shift_position(roll)
    # Find new position and property
    current_position = current_player.current_position - 1
    square = properties[current_position]
    new_position = (current_position + roll) % 32
    new_square = properties[new_position]

    # Shift player position
    square.remove_player(current_player)
    new_square.add_player(current_player)
    current_player.current_position = new_position + 1
    new_square
  end

  def game_state
    puts 'Name      |  Position |  Money  | Property'
    (0...(number_of_players - 1)).each do |i|
      # Print player state
      player_state(players[i])
    end
    puts "Player #{number_of_players}  |   Computer System"
  end

  def player_state(player)
    player_property = player.properties.collect { |p| "#{p.name}(#{p.value})" }.join(', ')
    player_position = player.current_position.to_s.rjust(2, '0').rjust(8)
    player_point = player.money.to_s.rjust(5, '0')
    puts "#{player.name}  |#{player_position}   |  #{player_point}  | #{player_property}".colorize(player.color)
  end
end
