defmodule FoodOrderWeb.MainLive do
  use FoodOrderWeb, :live_view
  alias FoodOrderWeb.Main.{Hero, Items}

  def mount(_assigns, _sessions, socket) do
    {:ok, socket}
  end
end
