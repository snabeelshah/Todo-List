defmodule Todoest.TasksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Todoest.Tasks` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        completed: true,
        description: "some description",
        due_date: ~D[2025-03-24],
        title: "some title"
      })
      |> Todoest.Tasks.create_task()

    task
  end
end
