defmodule FoodOrderWeb.Live.Admin.ProductLive.IndexTest do
  use FoodOrderWeb.ConnCase
  import FoodOrder.ProductsFixtures
  import Phoenix.LiveViewTest

  describe "index" do
    setup [:create_product]

    test "list products", %{conn: conn, product: product} do
      {:ok, view, _html} = live(conn, ~p"/admin/products")
      assert has_element?(view, "header>div>h1", "List Products")
      assert has_element?(view, "#products")
      assert has_element?(view, "#products > :first-child > :first-child", product.name)
      assert has_element?(view, "#products > :first-child", Money.to_string(product.price))
      assert has_element?(view, "#products > :first-child", Atom.to_string(product.size))
    end
  end

  defp create_product(_) do
    product = product_fixture()
    %{product: product}
  end
end
