alias FoodOrder.Products

for _ <- 0..30,
    do:
      Products.create_product(%{
        description: "Some description",
        name: "Food #{:rand.uniform(10_000)}",
        price: :rand.uniform(10_000),
        size: Enum.random(~w/SMALL MEDIUM LARGE/),
        image_url: "product_#{Enum.random(1..4)}.jpeg"
      })
