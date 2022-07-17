defmodule FoodOrder.Carts.Core.HandleCartsTest do
  use FoodOrder.DataCase, async: true
  alias FoodOrder.Carts.Core.HandleCarts
  alias FoodOrder.Carts.Data.Cart

  describe "handle_carts/1" do
    test "Should create a new cart" do
      assert %Cart{
               id: 4444,
               items: [],
               total_items: 0,
               total_price: %Money{amount: 0, currency: :BRL},
               total_quantity: 0
             } == HandleCarts.create_carts(4444)
    end
  end
end
