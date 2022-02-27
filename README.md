# Exlivery

Exlivery is a simple app to create or update user orders, and it also generates a report in .csv

## Run app

Install dependencies

```bash
$ mix deps.get
```

Run tests

```bash
$ mix test
```

Run

```bash
$ iex -S mix

iex> Exlivery.start_agents()

iex> Exlivery.create_or_update_user(%{name: "name1", email: "email1", cpf: "cpf1", age: 22, address: "address1"})

iex> items = [%{description: "description1", category: :hamburguer, unity_price: 50.30, quantity: 2}, %{description: "description2", category: :pizza, unity_price: 15.10, quantity: 1}]

iex> Exlivery.create_or_update_order(%{user_cpf: "cpf1", items: items})

iex> Exlivery.Orders.Report.create()
```
