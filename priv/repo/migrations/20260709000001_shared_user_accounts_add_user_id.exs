defmodule Bonfire.Data.SharedUser.Repo.Migrations.SharedUserAccountsAddUserId do
  @moduledoc false
  use Ecto.Migration
  import Needle.Migration

  @join_table "bonfire_data_shared_user_accounts"

  # Record the specific user behind each co-manager link (the invited user, or the creator for the
  # bootstrap link) so the roster shows only that person and never the account's other personas.
  # Access stays account-level via `account_id`; this is the display/identity face of each link.
  # Nullable (weak) so legacy rows created before this column keep working.
  def up do
    alter table(@join_table) do
      add_pointer_if_not_exists(:user_id, :weak)
    end
  end

  def down do
    alter table(@join_table) do
      remove_if_exists(:user_id, :uuid)
    end
  end
end
