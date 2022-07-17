defmodule FoodOrder.CartsTest do
  use FoodOrder.DataCase, async: true
  alias FoodOrder.Carts

  describe "Carts" do
    test "Should create session" do
      assert :ok == Carts.create_session(4444)
    end
  end
end
