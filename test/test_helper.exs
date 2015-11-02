defmodule Russian.TestCase do
  use ExUnit.CaseTemplate

  using(opts) do
    quote do
      use ExSpec, unquote(opts)
    end
  end

  # setup do
  # end
end

ExUnit.start()
