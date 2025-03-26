import Config

# Database Configuration (Same as yours, no changes needed)
config :todoest, Todoest.Repo,
  username: "postgres",
  password: "pakistan@1947",
  database: "todoest_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# Endpoint Configuration (Critical Fixes)
config :todoest, TodoestWeb.Endpoint,
  http: [
    ip: {127, 0, 0, 1}, 
    port: 4000  # Hardcoded for Windows compatibility
  ],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "isivERno9MKMSehItjPeOuid1ZeTcsZ1sT4Kvpt/A6iXIFLXn7zNUdfEnHUGNpXk",
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:todoest, ~w(--sourcemap=inline --watch)]},
    tailwind: {Tailwind, :install_and_run, [:todoest, ~w(--watch)]}
  ],
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/todoest_web/(controllers|live|components)/.*(ex|heex)$"
    ]
  ]

# Disable symlink-dependent features (Windows Fix)
config :phoenix, :code_reloader, watch: []
config :phoenix_live_reload, :watchers, []

# Logger + Phoenix Settings (No changes needed)
config :logger, :console, format: "[$level] $message\n"
config :phoenix, :stacktrace_depth, 20
config :phoenix, :plug_init_mode, :runtime
config :phoenix_live_view,
  debug_heex_annotations: true,
  enable_expensive_runtime_checks: true
config :swoosh, :api_client, false