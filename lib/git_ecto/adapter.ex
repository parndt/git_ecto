defmodule GitEcto.Adapter do
  @behaviour Ecto.Adapter

  defmacro __before_compile__(_opts), do: :ok

  def prepare(operation, query), do: {:nocache, {operation, query}}
end
