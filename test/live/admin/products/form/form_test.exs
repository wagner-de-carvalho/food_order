defmodule FoodOrderWeb.Admin.Products.FormTest do
  use FoodOrderWeb.ConnCase
  import Phoenix.LiveViewTest
  alias FoodOrder.Products
  import FoodOrder.Factory

  describe "test product form" do
    setup :register_and_log_in_admin

    test "given an existing product, when try to update without information returns an error ", %{
      conn: conn
    } do

      product = insert(:product)
      {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

      assert view |> element("[data-role=edit-product][data-id=#{product.id}]") |> render_click()
      assert_patch(view, Routes.admin_product_path(conn, :edit, product))

      assert view
             |> form("##{product.id}", product: %{name: nil})
             |> render_submit() =~ "can&#39;t be blank"
    end

    test "load modal to insert product", %{conn: conn} do
      {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

      open_modal(view)

      assert has_element?(view, "[data-role=modal]")
      assert has_element?(view, "[data-role=product-form]")

      assert view
             |> form("#new", product: %{name: nil})
             |> render_change() =~ "can&#39;t be blank"
    end

    test "should cancel image upload ", %{conn: conn} do
      {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :new))

      upload = file_input(view, "#new", :photo, [
        %{
          last_modiefied: 1_594_171_879_000,
          name: "myfile.jpeg",
          content: "       ",
          type: "image/jpeg"
        }
      ])

      assert render_upload(upload, "myfile.jpeg", 100) =~ "100%"
      assert has_element?(view, "[data-role=image-loaded][data-id=#{hd(upload.entries)["ref"]}]", "100")
      #
      ref = "[data-role=cancel][data-id=#{hd(upload.entries)["ref"]}"
      assert has_element?(view, ref)
      assert element(view, ref) |> render_click()
      refute has_element?(view, ref)
    end

    test "When form is submitted, returns product created message", %{conn: conn} do
      {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))
      open_modal(view)

      payload = %{name: "pumpkin", description: "new product", price: 12, size: "small"}

      {:ok, _, html} =
        view
        |> form("#new", product: payload)
        |> render_submit()
        |> follow_redirect(conn, Routes.admin_product_path(conn, :index))

      assert html =~ "Product has been created"
      assert html =~ "pumpkin"
    end

    test "When form data are wrong, returns an error message", %{conn: conn} do
      {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))
      open_modal(view)

      payload = %{name: "pumpkin", description: "new product", price: 12, size: "small"}
      assert {:ok, _product} = Products.create_product(payload)

      assert view
             |> form("#new", product: payload)
             |> render_submit() =~ "has already been taken"
    end

    test "Given an existing product, when edit is clicked, executes the action", %{conn: conn} do
      product = insert(:product)
      {:ok, view, _html} = live(conn, Routes.admin_product_path(conn, :index))

      assert view
             |> element("[data-role=edit-product][data-id=#{product.id}]")
             |> render_click()

      assert view |> has_element?("#modal")
      assert_patch(view, Routes.admin_product_path(conn, :edit, product))

      assert view
             |> form("##{product.id}", product: %{name: nil})
             |> render_change() =~ "can&#39;t be blank"

      {:ok, view, html} =
        view
        |> form("##{product.id}", product: %{name: "Frutos do mar"})
        |> render_submit()
        |> follow_redirect(conn, Routes.admin_product_path(conn, :index))

      assert html =~ "Product has been updated"

      assert view
             |> has_element?("[data-role=product-name][data-id=#{product.id}]", "Frutos do mar")
    end

    defp open_modal(view) do
      view
      |> element("[data-role=add-new-product]", "New")
      |> render_click()
    end
  end
end
