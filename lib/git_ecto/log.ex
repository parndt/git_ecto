defmodule GitEcto.Log do
  defstruct [:commit, :author, :date, :message]

  def all(repo) do
    {:ok, entries} = Git.log(
      repo,
      [~s|--pretty=format:{"commit": "%H", "author": "%aN <%aE>", "date": "%aD", "message": "%f"}|]
    )

    entries
    |> String.split("\n")
    |> Enum.map(&Poison.decode!(&1))
    |> Enum.map(fn(entry) ->
      {:ok, date} = Calendar.DateTime.Parse.rfc2822_utc(entry["date"])
      %__MODULE__{
        commit: entry["commit"],
        author: entry["author"],
        date: date,
        message: entry["message"]
      }
    end)
  end
end
