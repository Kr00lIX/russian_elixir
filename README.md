# Russian Elixir
Russian language transliteration support for Elixir.


## Installation
Add the latest stable release to your `mix.exs` file:

```elixir
defp deps do
  [
    {:russian, "~> 0.0.2"}
  ]
end
```

## Usage
```elixir
	Russian.transliterate "Строка на русском языке"
	# => "Stroka na russkom yazyke"

```
