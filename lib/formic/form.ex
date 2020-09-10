defmodule Formic.Form do
  use Ecto.Schema
  alias Ecto.Changeset
  alias Formic.CompoundValidator

  @primary_key false
  embedded_schema do
    field :name, :string
    field :age, :integer
    field :pop, :boolean
    field :pop__course, :string
  end

  def changeset(form \\ %__MODULE__{}, params \\ %{}) do
    form
    |> Changeset.cast(params, ~w[name age pop pop__course]a)
    |> Changeset.validate_required(~w[name age pop]a)
    |> CompoundValidator.validate_followup_questions_answered(%{pop: [:course]})
    |> Changeset.validate_inclusion(:age, 1..150,
      message: "is invalid. It must be a number greater than 0."
    )
  end
end
