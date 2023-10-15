class Player
  @@number_of_player = 0
  attr_accessor :name, :money, :properties, :player_number, :current_position, :color

  def initialize(name, money, color)
    @name = name
    @money = money
    @color = color

    @properties = []
    @player_number = @@number_of_player+=1
    @current_position = 1
  end

  def add_property(property)
    properties<<property
  end

  def delete_property(property)
    properties.delete(property)
  end
end