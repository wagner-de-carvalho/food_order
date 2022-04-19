defmodule FoodOrder.Factory do
  use ExMachina.Ecto, repo: FoodOrder.Repo
  alias FoodOrder.Products.Product

  def product_factory do
    %Product{
      description: Faker.Food.description(),
      name: Faker.Food.dish(),
      price: Enum.random(1..4500),
      size: Faker.Pizza.size()
    }
  end
end
