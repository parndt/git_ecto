defmodule GitEcto.Adapter do
  alias GitEcto.{Client}
  @behaviour Ecto.Adapter

  defmacro __before_compile__(_opts), do: :ok

  def prepare(operation, query), do: {:nocache, {operation, query}}

  def autogenerate(field_type), do: :ok
  def child_spec(_repo, options) do
    path = Keyword.get(options, :path)
    Supervisor.Spec.worker(Client, [%Git.Repository{path: path}])
  end
  def delete(repo, schema_meta, filters, options), do: raise "Not supported by adapter"
  def dumpers(primitive_type, ecto_type), do: raise "Not supported by adapter"
  def ensure_all_started(repo, type), do: raise "Not supported by adapter"
  def execute(repo, query_meta, query, params, arg4, options), do: raise "Not supported by adapter"
  def insert(repo, schema_meta, fields, returning, options), do: raise "Not supported by adapter"
  def insert_all(repo, schema_meta, header, list, returning, options), do: raise "Not supported by adapter"
  def loaders(primitive_type, ecto_type), do: raise "Not supported by adapter"
  def prepare(atom, query), do: raise "Not supported by adapter"
  def update(repo, schema_meta, fields, filters, returning, options), do: raise "Not supported by adapter"
end
