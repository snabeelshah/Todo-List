# Build stage
FROM elixir:1.15.7 AS builder

# Install build tools
RUN apt-get update && \
    apt-get install -y build-essential git && \
    apt-get clean

# Install Node.js (required for assets)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

WORKDIR /app

# Install Hex and Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Cache dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only prod

# Copy all files
COPY . .

# Compile project
RUN mix compile

# Build assets
RUN mix assets.deploy

# Release stage
FROM elixir:1.15.7

WORKDIR /app

# Copy compiled release
COPY --from=builder /app/_build/prod/rel/todoest ./

# Set environment
ENV MIX_ENV=prod
ENV PORT=4000

# Run migrations and start
CMD ["bin/todoest", "start"]