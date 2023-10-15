require_relative './player.rb'
require_relative './property.rb'

class Board
  BOARD_POSITION = [0, 1, 2, 3, 4, 5, 6, 7, 8, 31, 9, 30, 10, 29, 11, 28, 12, 27, 13, 26, 14, 25, 15, 24, 23, 22, 21, 20, 19, 18, 17, 16]
  DEFAULT_POINT = 10000
  START_POSITION = 0
  SPECIAL_POSITION = [8,16,24]
  PLAYER_COLORS = %i{red yellow blue green brown} 
  attr_accessor :properties, :players, :number_of_players

  def initialize(number_of_players)
    @properties = []
    @players = []
    @number_of_players = number_of_players

    # Create Players for Board
    create_players

    # Create Random property for Board of Company, Garden & Museum with random value and rent
    # Assign that propery to random player
    create_property

    # Set Start Position for Playes
    add_payers_at_start_position
  end

  def add_property(property)
    @properties << property
  end

  def add_player(player)
    @players << player
  end

  def display_board
    puts "--------------------------------------------------------------------------------------------"
    puts "|                                 BOARD - SQUARE SHOWDOWN                                   |"
    puts "--------------------------------------------------------------------------------------------"
    board_size = 9
    board_cell = 0
    (0...board_size).each do |row|
      print_row = "|"
      (0...board_size).each do |col|
        #check middle cell(blank) 
        if (1...8).include?(row) && (1...8).include?(col)
          print_row += " "*9
          next
        end
        
        print_row += "#{square_text(board_cell)}|"

        board_cell += 1
      end
      puts print_row
    end
    puts "--------------------------------------------------------------------------------------------"
  end

  private

  def square_text(board_cell)
    position = BOARD_POSITION[board_cell]
    square = properties[position]
    if square.players.length > 0
      player_at_position = square.players.collect(&:player_number).join(',')
      return "P#{player_at_position}".to_s.rjust(8, ' ')
    end 
    " #{(position+1).to_s.rjust(2, '0')}_#{square.rent.to_s.rjust(3, '0')} ".colorize(square.owner.color)
  end

  def create_property
    0.upto(31) do |i|
      player_number = rand(0..(number_of_players-2))
      random_player = players[player_number]
      property = Property.random_propery(i)
      property.owner = random_player
      random_player.add_property(property)
      add_property(property)
    end
  end

  def create_players
    (1...number_of_players).each do |player|
      color = PLAYER_COLORS[player-1]
      add_player(Player.new("Player #{player}", DEFAULT_POINT, color))
    end
  end

  def add_payers_at_start_position
    properties[START_POSITION].players = players.dup
  end
end
