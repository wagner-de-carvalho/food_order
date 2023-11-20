defmodule FoodOrderWeb.PageLiveTest do
  use FoodOrderWeb.ConnCase
  import FoodOrder.ProductsFixtures
  import Phoenix.LiveViewTest

  test "load main hero page html", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")
    hero_cta = "[data-role=hero-cta]"
    assert has_element?(view, "[data-role=hero]")
    assert has_element?(view, hero_cta)

    assert view |> element(hero_cta <> ">h1") |> render() =~ "Right now!"
    assert view |> element(hero_cta <> ">h6") |> render() =~ "Make your order"
    assert view |> element(hero_cta <> ">button") |> render() =~ "Order now"
    assert has_element?(view, "[data-role=hero-img]")
  end

  test "load products", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/")
    assert has_element?(view, "[data-role=products-section]")
    assert has_element?(view, "[data-role=products-list]")
    assert has_element?(view, "[data-role=products-section]>h1", "All foods")
  end

  test "load main item elements", %{conn: conn} do
    product = product_fixture()
    {:ok, view, _html} = live(conn, ~p"/")
    assert has_element?(view, "[data-role=item][data-id=#{product.id}]")

    assert has_element?(
             view,
             "[data-role=item-details][data-id=#{product.id}]>h2",
             product.name
           )

    assert has_element?(
             view,
             "[data-role=item-details][data-id=#{product.id}]>div>span",
             product.price.amount |> Money.new() |> Money.to_string()
           )

    assert view
           |> element("[data-role=item-details][data-id=#{product.id}]>div>button")
           |> render() =~ "Add"
  end
end
