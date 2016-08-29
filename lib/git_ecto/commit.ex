defmodule GitEcto.Commit do
  use Ecto.Schema
  @primary_key {:sha, :binary_id, [autogenerate: false]} # id is the API url of the user
  schema "commits" do
    # field :sha, :string
    field :author, :string
    field :date, Ecto.DateTime
    field :message, :string
    field :patch, :string
  end

  @required ~w(sha)
  @optional ~w()

  def changeset(user, params \\ :empty) do
    user
    |> Ecto.Changeset.cast(params, @required, @optional)
  end

  # defstruct [:sha, :author, :date, :message, :patch]

  def find(repo, sha) do
    {:ok, commit} = Git.show(repo, [sha, ~s|--pretty=format:{"commit": "%H", "author": "%aN <%aE>", "date": "%aD", "message": "%f"}|, "--color=never"])

    [json | patch] = commit |> String.split("\n")
    patch =
      patch
      |> Enum.join("\n")

    json =
      json
      |> Poison.decode!

    {:ok, date} = Calendar.DateTime.Parse.rfc2822_utc(json["date"])
    %__MODULE__{
      sha: sha,
      author: json["author"],
      date: date,
      message: json["message"],
      patch: patch
    }
  end
end
