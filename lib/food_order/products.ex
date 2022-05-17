defmodule FoodOrder.Products do
  alias FoodOrder.Products.Product
  alias FoodOrder.Products.ProductImage
  alias FoodOrder.Repo
  import Ecto.Query

  def list_products(params \\ []) when is_list(params), do: sort_by_params(params)

  defp sort_by_params(params) do
    query = from(p in Product)

    params
    |> Enum.reduce(query, fn
      {:name, name}, query ->
        name = "%" <> name <> "%"
        where(query, [q], ilike(q.name, ^name))

      {:sort, %{sort_by: sort_by, sort_order: sort_order}}, query ->
        order_by(query, [q], [{^sort_order, ^sort_by}])
    end)
    |> Repo.all()
  end

  def get!(id), do: Repo.get!(Product, id)

  def delete(id) do
    id
    |> get!()
    |> Repo.delete()
  end

  def create_product(attrs \\ %{}) do
    attrs
    |> Product.changeset()
    |> Repo.insert()
  end

  def update_product(product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  def change_product(product, params \\ %{}), do: Product.changeset(product, params)

  def get_image(product) do
    {product.product_url, product}
    |> ProductImage.url(:final, signed: true)
    |> get_image_url()
  end

  defp get_image_url(nil), do: ""

  defp get_image_url(url) do
    case Mix.env() do
      :prod ->
        url

      _ ->
        [_ | url] = String.split(url, "/priv/static")
        url
    end
  end
end
