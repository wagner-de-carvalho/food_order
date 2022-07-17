defmodule FoodOrderWeb.Main.ItemsTest do
  use FoodOrderWeb.ConnCase
  import Phoenix.LiveViewTest
  import FoodOrder.Factory

  test "load items", %{conn: conn} do
    {:ok, view, _html} = live(conn, Routes.main_path(conn, :index))
    assert has_element?(view, "#items-component")
    assert has_element?(view, "[data-role=items-info][data-id=all-foods]", "All Foods")
  end

  test "Should load more elements", %{conn: conn} do
    products = for _ <- 0..12, do: insert(:product)
    {:ok, view, _html} = live(conn, Routes.main_path(conn, :index))

    [products_page_1, products_page_2] =
      products
      |> Enum.chunk_every(8)

    Enum.each(products_page_1, fn product ->
      assert has_element?(view, "#item-#{product.id}")
    end)

    Enum.each(products_page_2, fn product ->
      refute has_element?(view, "#item-#{product.id}")
    end)

    view
    |> element("#products-loading")
    |> render_hook("load-more", %{})

    Enum.each(products_page_2, fn product ->
      assert has_element?(view, "#item-#{product.id}")
    end)
  end
end
