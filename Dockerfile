FROM ghcr.io/astral-sh/uv:python3.11-alpine

WORKDIR /app

# Install the Alpaca MCP server directly from the package registry
RUN uv pip install --system alpaca-mcp-server

# Expose Render's default port 
EXPOSE 10000

# Run using the required web transport layer for Render.
# Using shell form allows Render to dynamically inject the $PORT variable.
# CMD alpaca-mcp-server serve --transport sse --host 0.0.0.0 --port $PORT
CMD STARLETTE_ALLOWED_HOSTS="*" alpaca-mcp-server serve --transport streamable-http --host 0.0.0.0 --port $PORT
