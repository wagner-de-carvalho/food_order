defmodule FoodOrder.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @sizes_values ~w/SMALL MEDIUM LARGE/a
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @fields ~w/name price size description image_url/a
  @required @fields -- [:image_url]

  schema "products" do
    field :description, :string
    field :name, :string
    field :image_url, :string
    field :price, Money.Ecto.Amount.Type
    field :size, Ecto.Enum, values: @sizes_values, default: :SMALL

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, @fields)
    |> validate_required(@required)
  end
end
