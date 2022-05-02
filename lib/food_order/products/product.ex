defmodule FoodOrder.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset
  import Waffle.Ecto.Schema
  alias FoodOrder.Products.ProductImage

  @primary_key {:id, :binary_id, autogenerate: true}
  # @foreign_key :binary_id

  @fields ~w/description/a
  @required_fields ~w/name price size/a

  schema "products" do
    field :name, :string
    field :price, Money.Ecto.Amount.Type
    field :size, :string
    field :description, :string
    field :product_url, ProductImage.Type
    timestamps()
  end

  def changeset(attrs \\ %{}) do
    changeset(%__MODULE__{}, attrs)
  end

  def changeset(product, attrs) do
    product
    |> cast(attrs, @fields ++ @required_fields)
    |> validate_required(@required_fields)
    |> cast_attachments(attrs, [:product_url])
    |> unique_constraint([:name], name: :products_name_index)
  end
end
