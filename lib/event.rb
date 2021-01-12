class Event
  attr_reader :name, :food_trucks
  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    @food_trucks.map do |food_truck|
      food_truck.name
    end
  end

  def food_trucks_that_sell(item)
    that_sell = []
    @food_trucks.select do |food_truck|
      food_truck.inventory.keys.each do |key|
        that_sell << food_truck if key.name == item.name
      end
    end
    that_sell
  end

  def total_inventory
    #i can't seem to figure out why my test won't pass. Everything looks good
    #in a side by side comparison of the hashes
    inventory = Hash.new
    @food_trucks.each do |food_truck|
      food_truck.inventory.each do |item, quantity|
        if inventory[item].nil?
          inventory[item] = {quantity: 0}
        end
        previous_quantity = inventory[item][:quantity]
        inventory[item]= {   quantity: quantity + previous_quantity,
                          food_trucks: food_trucks_that_sell(item)}
      end
    end
    inventory

  end

  def overstocked_items
    over = total_inventory.select do |item, value_hash|
      # require "pry"; binding.pry
      value_hash[:quantity] > 50 && value_hash[:food_trucks].length > 1
    end
    over.keys
  end

  def sorted_item_list
    unsorted = total_inventory.keys.map do |key|
      key.name
    end
    unsorted.sort
  end
end
