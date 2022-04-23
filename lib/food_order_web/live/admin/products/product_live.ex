defmodule FoodOrderWeb.Admin.ProductLive do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Products
  alias FoodOrderWeb.Admin.Products.Form

  def mount(_p, _session, socket) do
    products = Products.list_products()
    {:ok, socket |> assign(products: products)}
  end

  # def handle_params(params, _url, socket) do
  #   IO.inspect(params)
  #   {:noreply, socket}
  # end
end
