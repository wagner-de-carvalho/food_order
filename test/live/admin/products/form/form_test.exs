defmodule FoodOrderWeb.Admin.Products.FormTest do
  use FoodOrderWeb.ConnCase
  import Phoenix.LiveViewTest
  alias FoodOrder.Products

  test "load modal to insert product", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))
    assert has_element?(view, "[data-role=modal]")
    assert has_element?(view, "[data-role=product-form]")

    assert view
           |> form("#new-product", product: %{name: nil})
           |> render_change() =~ "can&#39;t be blank"
  end

  test "When form is submitted, returns product created message", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))
    payload = %{name: "pumpkin", description: "new product", price: 12, size: "small"}

    {:ok, _, html} =
      view
      |> form("#new-product", product: payload)
      |> render_submit()
      |> follow_redirect(conn, Routes.admin_product_path(conn, :index))

    assert html =~ "Product has been created"
    assert html =~ "pumpkin"
  end

  test "When form data are wrong, returns an error message", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))
    payload = %{name: "pumpkin", description: "new product", price: 12, size: "small"}
    assert {:ok, _product} = Products.create_product(payload)

    assert view
           |> form("#new-product", product: payload)
           |> render_submit() =~ "has already been taken"
  end
end
