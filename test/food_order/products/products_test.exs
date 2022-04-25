defmodule FoodOrder.ProductsTest do
  use FoodOrder.DataCase, async: true
  alias Ecto.Changeset
  alias FoodOrder.Products
  alias FoodOrder.Products.Product

  describe "list_products/0" do
    test "When function is called, returns a list" do
      products = Products.list_products()
      assert products == []
      assert Enum.count(products) >= 0
    end
  end

  describe "get/1" do
    test "When an id is given, returns a product" do
      payload = %{
        name: "Computador",
        price: 2890,
        size: "medium",
        description: "Computador Lenovo"
      }

      {:ok, product} = Products.create_product(payload)
      assert Products.get!(product.id).name == product.name
    end
  end

  describe "delete/1" do
    test "When an id is given, deletes a product" do
      payload = %{
        name: "Computador",
        price: 2890,
        size: "medium",
        description: "Computador Lenovo"
      }

      {:ok, product} = Products.create_product(payload)
      assert {:ok, _} = Products.delete(product.id)
      assert_raise Ecto.NoResultsError, fn -> Products.get!(product.id) end
    end
  end

  describe "create_product/1" do
    test "When all params arecorrect, creates a new product" do
      payload = %{
        name: "Computador",
        price: 2890,
        size: "medium",
        description: "Computador Lenovo"
      }

      assert {:ok, %Product{} = product} = Products.create_product(payload)
      assert product.description == payload.description
      assert product.name == payload.name
      # assert product.price == payload.price
      assert product.price == %Money{amount: 2890, currency: :BRL}
      assert product.size == payload.size
    end

    test "When any params is incorrect or missing, returns an error" do
      payload = %{name: "Computador", price: 2890, description: "Computador Lenovo"}
      assert {:error, %Changeset{}} = Products.create_product(payload)
    end

    test "When there is a product withe the same name, returns an error" do
      payload = %{
        name: "Computador",
        price: 2890,
        size: "medium",
        description: "Computador Lenovo"
      }

      assert {:ok, %Product{}} = Products.create_product(payload)
      assert {:error, %Changeset{} = changeset} = Products.create_product(payload)
      assert "has already been taken" in errors_on(changeset).name
    end
  end

  describe "update_product/2" do
    test "When params are correct, updates product" do
      payload = %{
        name: "Computador",
        price: 2890,
        size: "medium",
        description: "Computador Lenovo"
      }

      assert {:ok, product} = Products.create_product(payload)
      assert {:ok, %Product{} = product} = Products.update_product(product, %{name: "Notebook"})
      assert product.name == "Notebook"
    end
  end
end
