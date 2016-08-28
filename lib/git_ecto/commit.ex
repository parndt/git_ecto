defmodule GitEcto.Commit do
  defstruct [:sha, :author, :date, :message, :patch]

  def find(repo, sha) do
    {:ok, commit} = Git.show(repo, [sha, ~s|--pretty=format:{"commit": "%H", "author": "%aN <%aE>", "body": "%b", "date": "%aD", "message": "%f"}|, "--color=never"])

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
