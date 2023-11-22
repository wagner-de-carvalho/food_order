defmodule FoodOrderWeb.Live.Admin.ProductLive.IndexTest do
  use FoodOrderWeb.ConnCase
  import FoodOrder.ProductsFixtures

  describe "index" do
    setup [:create_product]

    test "list all products", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/admin/products")
      assert has_element?(view, "header>div>h1", "List Products")
    end
  end

  defp create_product(opts) do
    product = product_fixture()
    %{product: product}
  end
end
