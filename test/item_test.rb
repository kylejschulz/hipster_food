require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/food_truck'
class ItemTest < Minitest::Test
  def setup
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
  end

  def test_it_exists
    assert_instance_of Item, @item1
    assert_instance_of Item, @item2
  end

  def test_it_has_attributes
    assert_equal "Apple Pie (Slice)", @item2.name
    assert_equal 2.50, @item2.price
  end
end

# @food_truck = FoodTruck.new("Rocky Mountain Pies")
#
# #=> "Rocky Mountain Pies"
# @food_truck.name
# #=> {}
# @food_truck.inventory
# #=> 0
# @food_truck.check_stock(item1)
# @food_truck.stock(item1, 30)
# #=> {#<Item:0x007f9c56740d48...> => 30}
# @food_truck.inventory
# #=> 30
# @food_truck.check_stock(item1)
# @food_truck.stock(item1, 25)
#
# #=> 55
# @food_truck.check_stock(item1)
# @food_truck.stock(item2, 12)
# #=> {#<Item:0x007f9c56740d48...> => 55, #<Item:0x007f9c565c0ce8...> => 12}
# @food_truck.inventory
