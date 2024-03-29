defmodule FoodOrderWeb.CartLive do
  use FoodOrderWeb, :live_view
  alias FoodOrderWeb.Details

  def mount(_, _, socket) do
    {:ok, assign(socket, total_qty: Enum.random([0, 1]))}
  end

  defp empty_cart(assigns) do
    ~H"""
    <div class="py-16 container mx-auto text-center">
      <h1 class="text-3xl font-bold mb-2">Your cart is empty!</h1>
      <p class="text-neutral-500 text-lg mb-12">
        You probably haven't ordered any food yet<br /> To order a good food go to the main page
      </p>

      <Heroicons.shopping_bag solid class="w-20 h-20 mx-auto text-orange-500" />
      <a
        href={~p"/"}
        class="inline-block px-6 py-2 rounded-full bg-orange-500 text-white font-bold mt-12"
      >
        Go back
      </a>
    </div>
    """
  end
end
