defmodule FoodOrder.ProductFixtures do
  alias FoodOrder.Products

  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        description: Faker.Food.description(),
        name: Faker.Food.dish(),
        price: Enum.random(1..4500),
        size: Faker.Pizza.size()
      })
      |> Products.create_product()

    product
  end
end
