alias FoodOrder.Accounts
alias FoodOrder.Factory
alias FoodOrder.Products

user = %{email: "user@gmail.com", password: "W_elixirpro17", role: "USER"}
user_admin = %{email: "admin@gmail.com", password: "W_elixirpro17", role: "ADMIN"}
Accounts.register_user(user)
Accounts.register_user(user_admin)

# waffle
# {:ok, product} =
Enum.each(1..200, fn _ ->
  image = :rand.uniform(4)

  %{
    name: Faker.Food.dish(),
    description: Faker.Food.description(),
    price: :random.uniform(10_000),
    size: Enum.random(["small", "medium", "large"]),
    product_url: %Plug.Upload{
      content_type: "image/png",
      filename: "product_#{image}.jpg",
      path: "priv/static/images/product_#{image}.jpg"
    }
  }
  |> Products.create_product()
end)
