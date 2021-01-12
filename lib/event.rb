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
end
