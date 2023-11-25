defmodule FoodOrderWeb.Admin.ProductLive.Index do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Products
  alias FoodOrder.Products.Product
  alias FoodOrderWeb.Admin.ProductLive.Form

  def mount(_, _, socket) do
    products = Products.list_products()
    {:ok, assign(socket, products: products)}
  end

  def handle_params(_, _, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action)}
  end

  defp apply_action(socket, :new) do
    socket
    |> assign(:page_title, "New Product")
    |> assign(:product, %Product{})
  end

  defp apply_action(socket, :index), do: assign(socket, :page_title, "List Products")
end
