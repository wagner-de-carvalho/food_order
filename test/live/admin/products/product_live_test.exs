defmodule FoodOrderWeb.Admin.ProductLiveTest do
  use FoodOrderWeb.ConnCase, async: true
  import Phoenix.LiveViewTest
  import FoodOrder.Factory

  describe "default page product" do
    setup :register_and_log_in_admin

    test "load page", %{conn: conn} do
      product = insert(:product)
      {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))
      assert has_element?(view, "[data-role=product-section]")
      assert has_element?(view, "[data-role=product-table]")
      assert has_element?(view, "[data-id=head-name]", "Name")
      assert has_element?(view, "[data-id=head-price]", "Price")
      assert has_element?(view, "[data-id=head-size]", "Size")
      assert has_element?(view, "[data-id=head-actions]", "Actions")
      assert has_element?(view, "[data-role=product-list]")
      # TEST Product
      assert has_element?(view, "[data-role=product-item][data-id=#{product.id}]")
      assert has_element?(view, "[data-role=product-name][data-id=#{product.id}]", product.name)

      assert has_element?(
               view,
               "[data-role=product-price][data-id=#{product.id}]"
             )

      assert has_element?(view, "[data-role=product-size][data-id=#{product.id}]", product.size)

      assert has_element?(view, "[data-role=product-actions][data-id=#{product.id}]")
    end

    test "given an existing product, when delete is clicked, removes it from db and updates page",
         %{conn: conn} do
      product = insert(:product)
      {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))
      assert has_element?(view, "[data-role=delete][data-id=#{product.id}]", "Delete")

      assert view
             |> element("[data-role=delete][data-id=#{product.id}]", "Delete")
             |> render_click()

      refute has_element?(view, "[data-role=delete][data-id=#{product.id}]")
    end

    test "clique filtrar por patches", %{conn: conn} do
      {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

      view
      |> element("[data-role=sort][data-id=name]")
      |> render_click()

      assert_patched(view, "/admin/products?sort_by=name&sort_order=asc&name=")

      view
      |> element("[data-role=sort][data-id=name]")
      |> render_click()

      assert_patched(view, "/admin/products?sort_by=name&sort_order=desc&name=")
    end
  end
end
