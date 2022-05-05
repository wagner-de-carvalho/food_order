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
    test "When all params are correct, creates a new product" do
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
      assert "" == Products.get_image(product)
    end

    test "When all params are correct, creates a new product with image and get image url" do
      file_upload =
      %Plug.Upload{
        content_type: "image/png",
        filename: "photo.png",
        path: "test/support/fixtures/photo.png"
      }
      payload =
      %{
        name: "Computador",
        price: 2890,
        size: "medium",
        description: "Computador HP",
        product_url: file_upload
      }

      assert {:ok, %Product{} = product} = Products.create_product(payload)
      [url |_] = Products.get_image(product)
      assert String.contains?(url, file_upload.filename)
    end

    test "create product with invalid image type" do
      file_upload =
      %Plug.Upload{
        content_type: "image/svg",
        filename: "photo.svg",
        path: "test/support/fixtures/photo.svg"
      }
      payload =
      %{
        name: "Computador",
        price: 2890,
        size: "medium",
        description: "Computador HP",
        product_url: file_upload
      }

      assert {:error, changeset} = Products.create_product(payload)
      assert "file type is invalid" in errors_on(changeset).product_url
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
