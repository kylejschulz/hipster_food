require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/food_truck'
require './lib/event'
class EventTest < Minitest::Test
  def setup
    @food_truck1 = FoodTruck.new("Rocky Mountain Pies")#=> #<FoodTruck:0x00007fe1348a1160...>
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})#=> #<Item:0x007f9c56740d48...>
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})#=> #<Item:0x007f9c565c0ce8...>
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})#=> #<Item:0x007f9c562a5f18...>
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})#=> #<Item:0x007f9c56343038...>
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")#=> #<FoodTruck:0x00007fe1349bed40...>
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    @food_truck3 = FoodTruck.new("Palisade Peach Shack")#=> #<FoodTruck:0x00007fe134910650...>
    @food_truck3.stock(@item1, 65)
    @food_truck3.stock(@item3, 10)
    @event = Event.new("South Pearl Street Farmers Market")#=> #<Event:0x00007fe134933e20...>
  end


  def test_it_exists
    assert_instance_of Event, @event
  end

  def test_it_has_attributes
    assert_equal "South Pearl Street Farmers Market", @event.name#=>
  end

  def test_it_can_have_food_trucks_and_add_them
    assert_equal [], @event.food_trucks#=>

    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)

    assert_equal [@food_truck1, @food_truck2, @food_truck3], @event.food_trucks#=>
  end

  def test_it_return_food_truck_names
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)

    assert_equal ["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"], @event.food_truck_names
  end

  def test_food_trucks_that_sell_item
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)

    assert_equal [@food_truck1, @food_truck3], @event.food_trucks_that_sell(@item1)
    assert_equal [@food_truck2], @event.food_trucks_that_sell(@item4)
  end

  def test_it_can_return_total_inventory
    #i don't know why this isn't passing
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    expected = {
                  @item1 => {
                    quantity: 100,
                    food_trucks: [@food_truck1, @food_truck3]
                  },
                  @item2=> {
                    quantity: 7,
                    food_trucks: [@food_truck1]
                  },
                  @item4=> {
                    quantity: 50,
                    food_trucks: [@food_truck2]
                  },
                  @item3 => {
                    quantity: 35,
                    food_trucks: [@food_truck1, @food_truck3]
                  },
                }

    assert_equal expected.length, @event.total_inventory.length
    assert_equal [@food_truck1, @food_truck3], @event.total_inventory.values.first[:food_trucks]
    assert_equal expected, @event.total_inventory
  end

  def test_it_can_id_overstocked_items
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)

    assert_equal [@item1], @event.overstocked_items
  end

  def test_it_can_sort_item_list
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)
    assert_equal ["Apple Pie (Slice)", "Banana Nice Cream", "Peach Pie (Slice)", "Peach-Raspberry Nice Cream"], @event.sorted_item_list
  end
end

#
