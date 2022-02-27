defmodule Exlivery.Orders.Report do
  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.{Item, Order}

  def create(filename \\ "report.csv") do
    order_list = build_order_list()

    File.write(filename, order_list)

    {:ok, "Report has been generated"}
  end

  defp build_order_list() do
    OrderAgent.get_all()
    |> Map.values()
    |> Enum.map(fn order -> order_string(order) end)
  end

  defp order_string(%Order{user_cpf: cpf, items: items, total_price: total_price}) do
    Enum.map(items, fn item -> item_string(cpf, item, total_price) end)
  end

  defp item_string(
         cpf,
         %Item{
           category: category,
           unity_price: unity_price,
           quantity: quantity
         },
         total_price
       ) do
    "#{cpf},#{category},#{quantity},#{unity_price},#{total_price}\n"
  end
end
