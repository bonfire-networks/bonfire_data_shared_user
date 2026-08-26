defmodule Bonfire.Data.SharedUser.Repo.Migrations.AddSharedUserIndexes do
  @moduledoc false
use Ecto.Migration 
  use Needle.Migration.Indexable

  def up do
    Bonfire.Data.SharedUser.Migration.add_shared_user_indexes()
  end

  def down, do: nil
end
