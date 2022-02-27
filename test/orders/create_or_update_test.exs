defmodule ExliveryTest.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  import ExliveryTest.Support.Factory

  alias Exlivery.Orders.CreateOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      Exlivery.start_agents()

      cpf = "12345678910"
      user = build(:user, cpf: cpf)

      UserAgent.save(user)

      item1 = %{
        description: "Item1 description",
        category: :hamburguer,
        quantity: 2,
        unity_price: "20.50"
      }

      item2 = %{
        description: "Item2 description",
        category: :pizza,
        quantity: 2,
        unity_price: "99.50"
      }

      {:ok, user_cpf: cpf, item1: item1, item2: item2}
    end

    test "when all params are valid, saves the order", %{
      user_cpf: cpf,
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: cpf, items: [item1, item2]}

      response = CreateOrUpdate.call(params)

      assert {:ok, _uuid} = response
    end

    test "when there is no user with given cpf, returns an error", %{item1: item1, item2: item2} do
      params = %{user_cpf: "00000000000", items: [item1, item2]}

      response = CreateOrUpdate.call(params)

      assert response == {:error, "User not found"}
    end

    test "when there are invalid itens, return an error", %{
      user_cpf: cpf,
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: cpf, items: [%{item1 | quantity: 0}, item2]}

      response = CreateOrUpdate.call(params)
      expected_response = {:error, "Invalid items"}

      assert response == expected_response
    end

    test "when there are no itens, return an error", %{user_cpf: cpf} do
      params = %{user_cpf: cpf, items: []}

      response = CreateOrUpdate.call(params)
      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
