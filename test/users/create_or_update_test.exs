defmodule ExliveryTest.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreateOrUpdate

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "when all params are valid, saves the user" do
      params = %{
        name: "Username",
        email: "test@mail.com",
        cpf: "12345678910",
        age: 22,
        address: "Address test"
      }

      response = CreateOrUpdate.call(params)
      expected_response = {:ok, "User created or updated successfully"}

      assert response == expected_response
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "Username",
        email: "test@mail.com",
        cpf: "12345678910",
        age: 17,
        address: "Address test"
      }

      response = CreateOrUpdate.call(params)
      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
