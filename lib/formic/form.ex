defmodule Formic.Form do
  use Ecto.Schema
  alias Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :song, :string
    field :start, :integer
    field :custom_intro, :boolean
    field :custom_intro__type, :string
  end

  def changeset(form \\ %__MODULE__{}, params \\ %{}) do
    form
    |> Changeset.cast(params, ~w[song start custom_intro custom_intro__type]a)
    |> Changeset.validate_required(~w[song start custom_intro]a)
    |> validate_followup_questions_answered(%{custom_intro: [:type]})
    |> Changeset.validate_inclusion(:start, 0..150,
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
