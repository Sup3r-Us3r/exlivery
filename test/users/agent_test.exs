defmodule ExliveryTest.Users.AgentTest do
  use ExUnit.Case

  import ExliveryTest.Support.Factory

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.User

  describe "save/1" do
    test "saves the user" do
      user = build(:user)

      UserAgent.start_link(%{})

      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})

      {:ok, cpf: "98765432100"}
    end

    test "when the user is found, returns the user", %{cpf: cpf} do
      :user
      |> build(cpf: cpf)
      |> UserAgent.save()

      response = UserAgent.get(cpf)

      expected_response =
        {:ok,
         %User{
           address: "Address test",
           age: 22,
           cpf: "98765432100",
           email: "test@mail.com",
           name: "Username"
         }}

      assert response == expected_response
    end

    test "when the user is not found, returns an error" do
      response = UserAgent.get("00000000000")
      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
