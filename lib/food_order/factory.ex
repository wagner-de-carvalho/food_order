defmodule FoodOrder.Factory do
  use ExMachina.Ecto, repo: FoodOrder.Repo
  alias FoodOrder.Products.Product

  def product_factory do
    %Product{
      description: Faker.Food.description(),
      name: Faker.Food.dish(),
      price: :rand.uniform(10_000),
      size: Faker.Pizza.size()
    }
  end
end

# %Product{
#   description: Faker.Food.description(),
#   name: Faker.Food.dish(),
#   price: :rand.uniform(10_000),
#   size: Faker.Pizza.size(),
#   product_url: %Plug.Upload{
#     content_type: "image/png",
#     filename: "product_#{image}.jpg",
#     path: "priv/static/images/product_#{image}.jpg"
#   }
# }
