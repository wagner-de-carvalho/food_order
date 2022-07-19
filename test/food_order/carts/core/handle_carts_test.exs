defmodule FoodOrder.Carts.Core.HandleCartsTest do
  use FoodOrder.DataCase, async: true
  import FoodOrder.Carts.Core.HandleCarts
  import FoodOrder.Factory
  alias FoodOrder.Carts.Data.Cart

  @start_cart %Cart{
    id: 444_444,
    items: [],
    total_price: %Money{amount: 0, currency: :BRL},
    total_quantity: 0
  }

  describe "handle carts" do
    test "Should create a new Cart" do
      assert @start_cart == create_carts(444_444)
    end

    test "Should add a new item in the cart" do
      product = insert(:product)
      cart = add_new_product(@start_cart, product)

      assert 1 == cart.total_quantity
      # assert [product] == cart.items
      assert product.price == cart.total_price
    end

    test "Should add the same item twice" do
      product = insert(:product)

      cart =
        @start_cart
        |> add_new_product(product)
        |> add_new_product(product)

      assert 2 == cart.total_quantity
      assert Money.add(product.price, product.price) == cart.total_price
      assert [%{item: product, quantity: 2}] == cart.items
    end

    test "Should remove an item" do
      product = insert(:product)
      product2 = insert(:product)

      cart =
        @start_cart
        |> add_new_product(product)
        |> add_new_product(product)
        |> add_new_product(product2)

      assert 3 == cart.total_quantity

      assert Money.add(product.price, product.price) |> Money.add(product2.price) ==
               cart.total_price

      assert [%{item: product, quantity: 2}, %{item: product2, quantity: 1}] == cart.items

      cart = remove(cart, product.id)

      assert 1 == cart.total_quantity
      assert product2.price == cart.total_price
      assert [%{item: product2, quantity: 1}] == cart.items
    end
  end
end
