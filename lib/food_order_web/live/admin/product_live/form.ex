defmodule FoodOrderWeb.Admin.ProductLive.Form do
  use FoodOrderWeb, :live_component
  alias FoodOrder.Products

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
        phx-target={@myself}
      >
        <.input field={f[:name]} label="Name" />
        <.input field={f[:description]} type="textarea" label="Description" />
        <.input field={f[:price]} type="number" label="Price" />

        <:actions>
          <.button phx-disable-with="saving ...">Create Product</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def handle_event("validate", %{"product" => product_params}, socket) do
    IO.inspect(product_params, label: "product_params>> ")

    changeset =
      socket.assigns.product
      |> Products.change_product(product_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end
end
