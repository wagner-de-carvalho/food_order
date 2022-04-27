alias FoodOrder.Accounts
alias FoodOrder.Factory

user = %{email: "user@gmail.com", password: "W_elixirpro17", role: "USER"}
user_admin = %{email: "admin@gmail.com", password: "W_elixirpro17", role: "ADMIN"}
Accounts.register_user(user)
Accounts.register_user(user_admin)
