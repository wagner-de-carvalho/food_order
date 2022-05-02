alias FoodOrder.Accounts
alias FoodOrder.Factory
alias FoodOrder.Products

user = %{email: "user@gmail.com", password: "W_elixirpro17", role: "USER"}
user_admin = %{email: "admin@gmail.com", password: "W_elixirpro17", role: "ADMIN"}
Accounts.register_user(user)
Accounts.register_user(user_admin)

# waffle
# {:ok, product} =
product =
  %{
    name: Faker.Food.dish(),
    description: Faker.Food.description(),
    price: :random.uniform(10_000),
    size: "small",
    product_url: %Plug.Upload{
      content_type: "image/png",
      filename: "logo.png",
      path: "priv/static/images/logo.png"
    }
  }
  |> Products.create_product()
