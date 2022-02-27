defmodule ExliveryTest.Orders.ReportTest do
  use ExUnit.Case

  import ExliveryTest.Support.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Report

  describe "create/1" do
    setup do
      OrderAgent.start_link(%{})

      :ok
    end

    test "creates the report file" do
      :order
      |> build()
      |> OrderAgent.save()

      :order
      |> build()
      |> OrderAgent.save()

      Report.create("report_test.csv")

      response = File.read!("report_test.csv")

      expected_response =
        "12345678910,pizza,1,35.3,76.30\n" <>
          "12345678910,hamburguer,2,20.50,76.30\n" <>
          "12345678910,pizza,1,35.3,76.30\n" <>
          "12345678910,hamburguer,2,20.50,76.30\n"

      assert response == expected_response
    end
  end
end
