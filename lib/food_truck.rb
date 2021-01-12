class FoodTruck
  attr_reader :name
  def initialize(name)
    @name = name
    @inventory = Hash.new
  end


  def inventory
    @inventory
  end

  def check_stock(item)
    if @inventory[item].nil?
      @inventory[item] = 0
    else
      @inventory[item]
    end
  end

  def stock(item, quantity)
    if @inventory[item].nil?
      @inventory[item] = 0
    end
    @inventory[item] += quantity
  end

  def potential_revenue
    @inventory.sum do |item, quantity|
      item.price * quantity
    end
  end
end
