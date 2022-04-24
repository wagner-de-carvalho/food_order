defmodule FoodOrderWeb.Admin.Products.FormTest do
  use FoodOrderWeb.ConnCase
  import Phoenix.LiveViewTest
  alias FoodOrder.Products
  import FoodOrder.Factory

  test "load modal to insert product", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    open_modal(view)

    assert has_element?(view, "[data-role=modal]")
    assert has_element?(view, "[data-role=product-form]")

    assert view
           |> form("#new", product: %{name: nil})
           |> render_change() =~ "can&#39;t be blank"
  end

  # test "when click to open modal and then close", %{conn: conn} do
  #   {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

  #   open_modal(view)

  #   assert view |> has_element?("#modal")

  #   assert view
  #   |> element("#close", "x")
  #   |> render_click()

  #   refute view |> has_element?("#modal")
  # end

  test "When form is submitted, returns product created message", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))
    open_modal(view)

    payload = %{name: "pumpkin", description: "new product", price: 12, size: "small"}

    {:ok, _, html} =
      view
      |> form("#new", product: payload)
      |> render_submit()
      |> follow_redirect(conn, Routes.admin_product_path(conn, :index))

    assert html =~ "Product has been created"
    assert html =~ "pumpkin"
  end

  test "When form data are wrong, returns an error message", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))
    open_modal(view)

    payload = %{name: "pumpkin", description: "new product", price: 12, size: "small"}
    assert {:ok, _product} = Products.create_product(payload)

    assert view
           |> form("#new", product: payload)
           |> render_submit() =~ "has already been taken"
  end

  test "Given an existing product, when edit is clicked, executes the action", %{conn: conn} do
    product = insert(:product)
    {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

    assert view
           |> element("[data-role=edit-product][data-id=#{product.id}]")
           |> render_click()

    assert view |> has_element?("#modal")
    assert_patch(view, Routes.admin_product_path(conn, :edit, product))

    assert view
           |> form("##{product.id}", product: %{name: nil})
           |> render_change() =~ "can&#39;t be blank"

    {:ok, view, html} =
      view
      |> form("##{product.id}", product: %{name: "Frutos do mar"})
      |> render_submit()
      |> follow_redirect(conn, Routes.admin_product_path(conn, :index))

    assert html =~ "Product has been updated"

    assert view
           |> has_element?("[data-role=product-name][data-id=#{product.id}]", "Frutos do mar")
  end

  defp open_modal(view) do
    view
    |> element("[data-role=add-new-product]", "New")
    |> render_click()
  end
end
