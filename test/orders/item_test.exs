defmodule ExliveryTest.Orders.ItemTest do
  use ExUnit.Case

  import ExliveryTest.Support.Factory

  alias Exlivery.Orders.Item

  describe "build/4" do
    test "when all params are valid, returns an item" do
      response =
        Item.build(
          "Pizza description",
          :pizza,
          "35.3",
          1
        )

      expected_response = {:ok, build(:item)}

      assert response == expected_response
    end

    test "when there is an invalid category, returns an error" do
      response =
        Item.build(
          "Pizza description",
          :aaa,
          "35.3",
          1
        )

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end

    test "when there is an invalid price, returns an error" do
      response =
        Item.build(
          "Pizza description",
          :pizza,
          "aaa",
          1
        )

      expected_response = {:error, "Invalid price"}

      assert response == expected_response
    end

    test "when there is an invalid quantity, returns an error" do
      response =
        Item.build(
          "Pizza description",
          :pizza,
          "35.3",
          0
        )

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
