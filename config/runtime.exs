import Config

config :todoest, TodoestWeb.Endpoint,
  server: true,
  http: [
    port: String.to_integer(System.get_env("PORT", "4000"))  # Fixed with default value
  ],
  url: [
    host: System.get_env("PHX_HOST", "localhost"),
    port: 443
  ]