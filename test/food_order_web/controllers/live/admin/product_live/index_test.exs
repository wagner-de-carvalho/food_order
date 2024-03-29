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

    test "add new product", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/admin/products")
      assert view |> element("header>div>a", "New Product") |> render_click()

      assert_patch(view, ~p"/admin/products/new")
      assert view |> has_element?("#new-product-modal")

      assert view
             |> form("#product-form", product: %{})
             |> render_change() =~ "be blank"

      {:ok, _view, html} =
        view
        |> form("#product-form",
          product: %{name: "Burger", description: "Smash Burger", price: 25.50}
        )
        |> render_submit()
        |> follow_redirect(conn, ~p"/admin/products")

      assert html =~ "created successfully"
      assert html =~ "Burger"
    end

    test "delete product", %{conn: conn} do
      {:ok, view, _html} = live(conn, ~p"/admin/products")
      product_id = "#products"
      assert has_element?(view, product_id)
      assert has_element?(view, "[href]", "Delete")

      view
      |> element("[href]", "Delete")
      |> render_click()

      refute has_element?(view, "[href]", "Delete")
    end
  end

  defp create_product(_) do
    product = product_fixture()
    %{product: product}
  end
end
