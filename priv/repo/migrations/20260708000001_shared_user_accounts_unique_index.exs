defmodule Bonfire.Data.SharedUser.Repo.Migrations.SharedUserAccountsUniqueIndex do
  @moduledoc false
  use Ecto.Migration

  @join_table "bonfire_data_shared_user_accounts"

  def up do
    # An account should be linked to a given shared user only once. The table originally had only
    # non-unique per-column indexes, so on existing instances there may be duplicate rows; remove
    # them before adding the unique index (creating it over duplicates would otherwise fail).
    execute("""
    DELETE FROM "#{@join_table}" a
    USING "#{@join_table}" b
    WHERE a.ctid < b.ctid
      AND a.shared_user_id = b.shared_user_id
      AND a.account_id = b.account_id
    """)

    create_if_not_exists(unique_index(@join_table, [:shared_user_id, :account_id]))
  end

  def down do
    drop_if_exists(unique_index(@join_table, [:shared_user_id, :account_id]))
  end
end
