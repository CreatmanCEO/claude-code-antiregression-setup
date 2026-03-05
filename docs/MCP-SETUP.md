# MCP Server Setup

MCP (Model Context Protocol) servers extend Claude Code's capabilities. They run locally — no extra cost.

## Prerequisites

- Node.js 18+ installed
- Claude Code installed and working

## Recommended MCP Servers

### Playwright — Browser Automation

Let Claude open browsers, take screenshots, click elements, and test UI.

```bash
claude mcp add playwright -- npx -y @executeautomation/playwright-mcp-server
```

**Usage:**
```
> Open a browser, navigate to localhost:3000 and take a screenshot
> Click the login button and verify the redirect works
> Fill in the registration form with test data and submit
```

> Note: The official `@modelcontextprotocol/server-puppeteer` is **deprecated**. Use Playwright instead.

### GitHub — Repository Integration

```bash
claude mcp add github -- npx -y @modelcontextprotocol/server-github
```

### PostgreSQL — Database Queries

```bash
claude mcp add postgres -- npx -y @modelcontextprotocol/server-postgres
```

### Context7 — Fresh Library Documentation

```bash
claude mcp add context7 -- npx -y @upstash/context7-mcp
```

## Verify Installation

In Claude Code:

```
/mcp
```

You should see servers listed with `connected` status.

## Troubleshooting

| Problem | Fix |
|---|---|
| Server shows `failed` | `/mcp` → select server → Reconnect |
| Tools not appearing | Restart Claude Code session |
| npx timeout | Check Node.js: `node --version` |
| Permission errors | Run terminal as Administrator (Windows) |

## Manual Configuration

If `claude mcp add` doesn't work, add to `~/.claude.json`:

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["-y", "@executeautomation/playwright-mcp-server"]
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"]
    }
  }
}
```

Restart Claude Code after editing.
