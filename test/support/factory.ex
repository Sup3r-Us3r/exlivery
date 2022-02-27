defmodule ExliveryTest.Support.Factory do
  use ExMachina

  alias Exlivery.Users.User
  alias Exlivery.Orders.{Item, Order}

  def user_factory do
    %User{
      name: "Username",
      email: "test@mail.com",
      cpf: "12345678910",
      age: 22,
      address: "Address test"
    }
  end

  def item_factory do
    %Item{
      description: "Pizza description",
      category: :pizza,
      unity_price: Decimal.new("35.3"),
      quantity: 1
    }
  end

  def order_factory do
    %Order{
      delivery_address: "Address test",
      items: [
        build(:item),
        build(:item,
          description: "Item description",
          category: :hamburguer,
          quantity: 2,
          unity_price: Decimal.new("20.50")
        )
      ],
      total_price: Decimal.new("76.30"),
      user_cpf: "12345678910"
    }
  end
end
