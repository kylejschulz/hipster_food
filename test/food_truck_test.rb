require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/food_truck'
class FoodTruckTest < Minitest::Test
  def setup
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @food_truck1 = FoodTruck.new("Rocky Mountain Pies")#=> #<FoodTruck:0x00007fe1348a1160...>
  end
  def test_it_exists
    assert_instance_of FoodTruck, @food_truck1
  end

  def test_it_has_attributes
    expected = {}
    assert_equal "Rocky Mountain Pies", @food_truck1.name
    assert_equal expected, @food_truck1.inventory
  end

  def test_it_can_stock_item_and_check_stock
    assert_equal 0, @food_truck1.check_stock(@item1)

    @food_truck1.stock(@item1, 30) #=>

    expected = {@item1 => 30}
    assert_equal expected, @food_truck1.inventory
    assert_equal 30, @food_truck1.check_stock(@item1)

    @food_truck1.stock(@item1, 25)

    assert_equal 55, @food_truck1.check_stock(@item1)

    @food_truck1.stock(@item2, 12)

    expected = {@item1 => 55, @item2 => 12}
    assert_equal expected, @food_truck1.inventory
  end

  def test_it_can_calculate_potential_revenue
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})#=> #<Item:0x007f9c562a5f18...>
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})#=> #<Item:0x007f9c56343038...>
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")#=> #<FoodTruck:0x00007fe1349bed40...>
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    @food_truck3 = FoodTruck.new("Palisade Peach Shack")#=> #<FoodTruck:0x00007fe134910650...>
    @food_truck3.stock(@item1, 65)

    assert_equal 148.75, @food_truck1.potential_revenue
    assert_equal 345.00, @food_truck2.potential_revenue
    assert_equal 243.75, @food_truck3.potential_revenue
  end
end
