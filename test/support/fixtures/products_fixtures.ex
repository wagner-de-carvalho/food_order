defmodule FoodOrder.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FoodOrder.Products` context.
  """
  alias FoodOrder.Products

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    attrs
    |> Enum.into(%{
      description: "Some description",
      name: "Food",
      price: :rand.uniform(10_000),
      size: :SMALL,
      image_url: "product_#{Enum.random(1..4)}.jpeg"
    })
    |> Products.create_product()
    |> then(&elem(&1, 1))
  end
end
