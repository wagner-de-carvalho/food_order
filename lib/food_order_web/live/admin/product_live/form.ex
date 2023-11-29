defmodule FoodOrderWeb.Admin.ProductLive.Form do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Products
  alias FoodOrder.Products.Product

  def mount(socket) do
    {:ok, socket}
  end

  def update(%{product: product} = assigns, socket) do
    changeset = Products.change_product(product)
    {:ok, socket |> assign(assigns) |> assign(changeset: changeset)}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.simple_form
        :let={f}
        for={@changeset}
        id="product-form"
        phx-change="validate"
        phx-submit="save"
        phx-target={@myself}
      >
        <.input field={f[:name]} label="Name" />
        <.input field={f[:description]} type="textarea" label="Description" />
        <.input field={f[:price]} label="Price" />

        <:actions>
          <.button phx-disable-with="saving ...">Save Product</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def handle_event("validate", %{"product" => product_params}, socket) do
    changeset =
      socket.assigns.product
      |> Products.change_product(product_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"product" => product_params}, socket) do
    save(socket, socket.assigns.action, product_params)
  end

  defp save(socket, :edit, product_params) do
    socket.assigns.product
    |> Products.update_product(product_params)
    |> then(fn {:ok, product} ->
      perform(socket, product, "Product updated successfully")
    end)
  end

  defp save(socket, :new, product_params) do
    product_params
    |> Products.create_product()
    |> then(fn {:ok, product} ->
      perform(socket, product, "Product created successfully")
    end)
  end

  defp perform(socket, args, message) do
    args
    |> then(fn
      %Product{} = product ->
        socket =
          socket
          |> put_flash(:info, message)
          |> push_navigate(to: socket.assigns.navigate)

        {:noreply, socket}

      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end)
  end
end
