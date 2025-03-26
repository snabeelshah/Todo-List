defmodule TodoestWeb.TaskHTML do
  use TodoestWeb, :html

  # Only import what you need
  import TodoestWeb.CoreComponents  # For <.form>, <.input> etc.
  
  embed_templates "task_html/*"
end