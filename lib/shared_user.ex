defmodule Bonfire.Data.SharedUser do
  @moduledoc """
  A mixin for shared user personas (which multiple accounts can use)
  """

  use Pointers.Mixin,
    otp_app: :bonfire_data_shared_user,
    source: "bonfire_data_shared_user"

  alias Bonfire.Data.Identity.Account
  alias Bonfire.Data.Identity.User
  alias Bonfire.Data.SharedUser

  alias Ecto.Changeset

  mixin_schema do
    field(:label, :string)

    belongs_to(:user, User, foreign_key: :id, define_field: false)

    many_to_many(:caretaker_accounts, Account, join_through: "bonfire_data_shared_user_accounts")
  end

  def changeset(user \\ %SharedUser{}, params) do
    Changeset.cast(user, params, [:label])
  end
end

defmodule Bonfire.Data.SharedUser.Migration do
  @moduledoc false
  use Ecto.Migration
  import Pointers.Migration

  # create_shared_user_table/{0,1}

  defp make_shared_user_table(exprs) do
    quote do
      require Pointers.Migration

      Pointers.Migration.create_mixin_table "bonfire_data_shared_user" do
        add(:label, :string, default: "Organisation")
        unquote_splicing(exprs)
      end

      flush()

      create table("bonfire_data_shared_user_accounts", primary_key: false) do
        add(:shared_user_id, strong_pointer(Bonfire.Data.SharedUser))
        add(:account_id, strong_pointer())
        # timestamps()
      end
    end
  end

  defmacro create_shared_user_table(), do: make_shared_user_table([])

  defmacro create_shared_user_table(do: {_, _, body}),
    do: make_shared_user_table(body)

  # drop_shared_user_table/0

  def drop_shared_user_table() do
    drop_mixin_table(Bonfire.Data.SharedUser)
    drop_if_exists(table("bonfire_data_shared_user_accounts"))
  end

  # migrate_shared_user/{0,1}

  defp mu(:up), do: make_shared_user_table([])

  defp mu(:down) do
    quote do: Bonfire.Data.SharedUser.Migration.drop_shared_user_table()
  end

  defmacro migrate_shared_user() do
    quote do
      if Ecto.Migration.direction() == :up,
        do: unquote(mu(:up)),
        else: unquote(mu(:down))
    end
  end

  defmacro migrate_shared_user(dir), do: mu(dir)
end
