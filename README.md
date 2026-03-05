# Claude Code Anti-Regression Setup

> Stop Claude Code from breaking your projects. Ready-to-use configs, agents, hooks, and templates.

## The Problem

Claude Code progressively breaks projects during long sessions due to **context window exhaustion** (~200K tokens). At 90% utilization, it forgets earlier decisions and introduces regressions. 80% of context gets consumed by file reads and tool results — not your conversation.

The community calls this **"context drift"** and it's the #1 source of AI-introduced regressions.

## The Solution

This repo provides a battle-tested anti-regression setup through four layers:

1. **CLAUDE.md** — Persistent project rules that survive context compaction
2. **Subagents** — Isolated AI specialists (planner, tester, reviewer) with separate context windows
3. **Hooks** — Automated test gates that block broken commits
4. **Rules** — Modular, glob-scoped coding standards

## What's Inside

```
├── CLAUDE.md.template              # Project constitution — fill in your details
├── .claude/
│   ├── settings.json                # Hooks: auto-test reminders, commit blocking
│   ├── agents/
│   │   ├── planner.md               # Research and planning (never writes code)
│   │   ├── tester.md                # Full test suite runner + regression checker
│   │   └── code-reviewer.md         # Quality, security and regression reviewer
│   └── rules/
│       ├── python-backend.md        # Python-specific rules (glob-scoped)
│       └── frontend.md              # Frontend-specific rules (glob-scoped)
├── plans/
│   └── .gitkeep                     # Planner agent saves implementation plans here
└── docs/
    ├── WORKFLOW.md                  # Daily anti-regression workflow guide
    └── MCP-SETUP.md                 # MCP server installation instructions
```

## Quick Start (15 minutes)

### 1. Copy configs to your project

```bash
git clone https://github.com/CreatmanCEO/claude-code-antiregression-setup.git
cp -r claude-code-antiregression-setup/.claude /path/to/your/project/
cp claude-code-antiregression-setup/CLAUDE.md.template /path/to/your/project/CLAUDE.md
mkdir -p /path/to/your/project/plans
```

### 2. Fill in CLAUDE.md

Open `CLAUDE.md` in your project root and replace all `[placeholders]` with your project's actual data.

### 3. Start Claude Code

```bash
claude
```

Claude reads `CLAUDE.md` automatically. Try:

```
> Use the planner agent to analyze our codebase and create a plan for [your task]
```

### 4. Adapt hooks

Edit `.claude/settings.json` — replace `python -m pytest tests/` with your project's test command.

## How It Works

### CLAUDE.md — The Most Important File

Claude reads this at the start of **every** session. It survives compaction. Your CRITICAL RULES live here.

**Key stat**: 60% of Claude Code support tickets come from the "ghost context" anti-pattern — working without CLAUDE.md. A simple CLAUDE.md resolves 90% of cases.

### Subagents — Isolated Context Windows

| Agent | Purpose | Why Isolated? |
|---|---|---|
| `planner` | Research codebase, create plans | Research reads many files — would bloat main context |
| `tester` | Run full test suite, catch regressions | Test output is verbose — stays out of working memory |
| `code-reviewer` | Review for quality, security, patterns | Fresh perspective without implementation bias |

### Hooks — Automated Safety Nets

Commit-blocking hook prevents Claude from committing code that breaks tests. Zero exceptions.

### Rules — Scoped Standards

Files in `.claude/rules/` load only when Claude works with matching file patterns — saves context.

## Recommended Workflow

See [docs/WORKFLOW.md](docs/WORKFLOW.md) for the complete daily workflow.

1. **Plan first**: `Use planner agent` → review → approve
2. **Small diffs**: One step → tests → next step
3. **Monitor context**: `/compact` at 60-70%
4. **Checkpoint**: `git commit` before risky changes
5. **Review**: `Use code-reviewer` before final commit
6. **Rewind if broken**: `Esc + Esc` → restore code only

## Recommended Stack

| Component | Tool | Cost |
|---|---|---|
| IDE | [Google Antigravity](https://antigravity.google) | Free |
| AI Coding Agent | Claude Code (Max subscription) | $100/mo |
| UI Testing | Gemini 3 Pro (built into Antigravity) | Free |
| Browser Automation | Playwright MCP | Free |

See [docs/MCP-SETUP.md](docs/MCP-SETUP.md) for MCP server installation.

## Contributing

PRs welcome! Priority: language-specific rules, framework-specific agents, additional hooks.

## Resources

- [awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code) — Curated list of skills, hooks, agents
- [claude-code-workflows](https://github.com/shinpr/claude-code-workflows) — Production-ready workflow plugins
- [Claude Code Docs: Best Practices](https://code.claude.com/docs/en/best-practices) — Official recommendations

## Author

**Nick** — Python developer and digital architect at **CREATMAN**

- GitHub: [@CreatmanCEO](https://github.com/CreatmanCEO)
- Website: [creatman.site](https://creatman.site)

## License

MIT
