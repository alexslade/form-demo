defmodule Formic.CompoundValidator do
  use Ecto.Schema
  alias Ecto.Changeset

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

  def error_for(changeset, field) do
    if changeset.changes[field] == nil do
      {field, "can't be blank"}
    else
      {}
    end
  end
end
