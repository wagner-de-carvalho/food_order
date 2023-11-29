defmodule FoodOrderWeb.Admin.ProductLive.Index do
  use FoodOrderWeb, :live_view
  alias FoodOrder.Products
  alias FoodOrder.Products.Product
  alias FoodOrderWeb.Admin.ProductLive.Form

  def mount(_, _, socket) do
    products = Products.list_products()
    {:ok, assign(socket, products: products)}
  end

  def handle_params(params, _, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    products = socket.assigns.products
    product = Enum.find(products, &(&1.id == id))
    Products.delete_product(product)
    delete_product = fn products -> Enum.filter(products, &(&1.id != id)) end
    {:noreply, update(socket, :products, &delete_product.(&1))}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    product = Products.get_product!(id)

    socket
    |> assign(:page_title, "Edit Product")
    |> assign(:product, product)
  end

  defp apply_action(socket, :new, _) do
    socket
    |> assign(:page_title, "New Product")
    |> assign(:product, %Product{})
  end

  defp apply_action(socket, :index, _), do: assign(socket, :page_title, "List Products")
end
