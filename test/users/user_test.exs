defmodule ExliveryTest.Users.UserTest do
  use ExUnit.Case

  import ExliveryTest.Support.Factory

  alias Exlivery.Users.User

  describe "build/5" do
    test "when all params are valid, returns the user" do
      response =
        User.build(
          "Username",
          "test@mail.com",
          "12345678910",
          22,
          "Address test"
        )

      expected_response = {:ok, build(:user)}

      assert response == expected_response
    end

    test "when there invalid params, returns an error" do
      response =
        User.build(
          "Username2",
          "test@mail.com",
          "12345678910",
          17,
          "Address test"
        )

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
