defmodule Formic.Form do
  use Ecto.Schema
  alias Ecto.Changeset

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
    |> validate_followup_questions_answered(%{pop: [:course]})
    |> Changeset.validate_inclusion(:age, 1..150,
      message: "is invalid. It must be a number greater than 0."
    )
  end

  def error_for(changeset, field) do
    if changeset.changes[field] == nil do
      {field, "can't be blank"}
    else
      {}
    end
  end

  def validate_followup_questions_answered(changeset, fields) do
    errors =
      for {key, values} <- fields do
        if changeset.changes[key] do
          values
          |> Enum.map(fn value -> error_for(changeset, String.to_atom("#{key}__#{value}")) end)
        else
          []
        end
      end

    error = List.first(errors)

    # TODO: This is shit, make this better
    if Enum.count(error) == 0 || error == [{}] do
      changeset
    else
      [{key, message}] = error
      Changeset.add_error(changeset, key, message)
    end
  end
end
