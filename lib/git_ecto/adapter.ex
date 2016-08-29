defmodule GitEcto.Adapter do
  alias GitEcto.{GitRepoHolder}
  @behaviour Ecto.Adapter

  defmacro __before_compile__(_opts), do: :ok

  def prepare(operation, query), do: {:nocache, {operation, query}}

  def autogenerate(field_type), do: :ok
  def child_spec(_repo, options) do
    path = Keyword.get(options, :path)
    Supervisor.Spec.worker(GitRepoHolder, [%Git.Repository{path: path}])
  end
  def delete(repo, schema_meta, filters, options), do: raise "Not supported by adapter"
  def dumpers(primitive, _type), do: [primitive]
  def ensure_all_started(repo, type), do: raise "Not supported by adapter"

  def execute(_repo, _query_meta, _query, [], arg4, options) do
    results =
      GitRepoHolder.repo
      |> GitEcto.Log.all
      |> Enum.map(fn(commit) -> [commit] end)

    {Enum.count(results), results}
  end

  def execute(_repo, _query_meta, _query, [params], _arg4, _options) do
    result =
      GitRepoHolder.repo
      |> GitEcto.Commit.find(params)

    {0, [[result]]}
  end

  def insert(repo, schema_meta, fields, returning, options), do: raise "Not supported by adapter"
  def insert_all(repo, schema_meta, header, list, returning, options), do: raise "Not supported by adapter"
  def loaders(primitive_type, ecto_type), do: raise "Not supported by adapter"
  def prepare(atom, query), do: raise "Not supported by adapter"
  def update(repo, schema_meta, fields, filters, returning, options), do: raise "Not supported by adapter"
end
