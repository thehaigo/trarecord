defmodule Trarecord.Factory do
  use ExMachina.Ecto, repo: Trarecord.Repo

  use Trarecord.UserFactory
  use Trarecord.FolderFactory
end
