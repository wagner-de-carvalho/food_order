alias FoodOrder.Products
alias FoodOrder.Products.Product
alias FoodOrder.Repo

product = %{name: "Computador", price: 2890, size: "medium", description: "Computador Lenovo"}
product2 = %{name: "Monitor", price: 1872, size: "medium", description: "Tela de computador"}
product3 = %{name: "Mouse", price: 234, size: "small", description: "Rato de computador"}

changeset = Product.changeset(product)
changeset2 = Product.changeset(product2)
show = Repo.all(Product)
