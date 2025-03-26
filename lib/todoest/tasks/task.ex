defmodule Todoest.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :title, :string
    field :description, :string
    field :completed, :boolean, default: false
    field :due_date, :date
    timestamps()
  end

  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :completed, :due_date])
    |> validate_required([:title])
  end
end