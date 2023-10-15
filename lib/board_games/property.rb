class Property
  attr_accessor :name, :owner, :value, :rent, :players

  PROPERTY_TYPE = %i{Company Garden Museum}
  def initialize(name, value, rent, owner = nil )
    @name = name
    @value = value
    @rent = rent
    @owner = owner
    @players = []
  end

  def self.random_propery(i)
    if Board::START_POSITION == i 
      return Property.new('Start', 0, 0)
    end
    return Property.new('Special', 0, 0) if Board::SPECIAL_POSITION.include?(i)
    index = rand(3)
    price = (index+1)*100
    rent = rand(50..price)
    propert_name = "#{PROPERTY_TYPE[rand(3)]} #{i+1}"
    Property.new(propert_name, price, rent)
  end

  def add_player(player)
    @players<< player
  end

  def remove_player(player)
    @players.delete(player)
  end
end