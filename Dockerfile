# Build stage
FROM elixir:1.15.7 AS builder

# Install build tools (including Node.js for assets)
RUN apt-get update && \
    apt-get install -y build-essential git curl && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean

WORKDIR /app

# Install Hex and Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Cache dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only prod

# Copy production-necessary files
COPY config config
COPY lib lib
COPY priv priv

# Only copy assets if they exist
COPY assets assets
RUN if [ -f "assets/package.json" ]; then \
    cd assets && \
    npm install && \
    cd .. && \
    mix assets.deploy; \
    fi

# Compile project (production only)
RUN MIX_ENV=prod mix compile && \
    MIX_ENV=prod mix release

# Final image - CHANGED TO bookworm for GLIBC 2.34+ support
FROM debian:bookworm-slim

# Install runtime deps - ADDED libstdc++6 explicitly
RUN apt-get update && \
    apt-get install -y openssl libstdc++6 && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --from=builder /app/_build/prod/rel/todoest ./

ENV MIX_ENV=prod
ENV PORT=4000

# Health check for Railway
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:4000/health || exit 1

CMD ["bin/todoest", "start"]