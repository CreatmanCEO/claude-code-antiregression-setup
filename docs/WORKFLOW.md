# Daily Anti-Regression Workflow

## Session Start

1. Open your IDE (Antigravity / VS Code)
2. Open terminal → run `claude`
3. Claude reads `CLAUDE.md` automatically
4. Quick orientation: "What do you know about this project?"

## Before Any Complex Task

**Always plan first:**

```
> Use the planner agent to research our codebase and create
> an implementation plan for [describe the feature/change].
> Do NOT write any code yet.
```

Wait for the plan → Read it carefully → Question assumptions → Adjust.

Only after you approve the plan:

```
> Implement Step 1 from the plan. Run tests after.
```

## During Implementation

### The 60% Rule

Never let context exceed 60-70%. Check with `/cost`.

- **At 60-70%** → `/compact "Preserve: list of modified files, test results, current plan step"`
- **Switching topics** → `/clear`
- **Resuming tomorrow** → `/resume` or `claude -c`

### Git Checkpoints

Before risky changes:

```
> git add -A && git commit -m "checkpoint: before [description]"
```

If Claude breaks something:
- `Esc + Esc` → restore code only (Claude checkpoint)
- `git reset --hard HEAD` (Git checkpoint)

### Step-by-Step Discipline

```
BAD:  "Add auth, update API, write tests, and deploy"
GOOD: "Implement Step 1: Add JWT token generation. Run tests after."
      [verify]
      "Implement Step 2: Add auth middleware. Run tests after."
      [verify]
```

## After Implementation

```
> Use the code-reviewer agent to review all changes since last commit
> Use the tester agent to run the full test suite
```

Only commit after both agents report clean results.

## Parallel Sessions (Advanced)

For complex work, open multiple terminals:

| Terminal | Purpose |
|---|---|
| Terminal 1 | Claude Code — main implementation |
| Terminal 2 | Claude Code — tests in parallel |
| Terminal 3 | Dev server / build watch |

3 sessions = effectively 600K tokens of context. `CLAUDE.md` serves as shared memory.

## Emergency Recovery

| Situation | Fix |
|---|---|
| Claude broke working code | `Esc + Esc` → restore code only |
| Multiple files corrupted | `git reset --hard HEAD` |
| Context is confused | `/clear` → start fresh (CLAUDE.md reloads) |
| Session is too long | `/compact "Preserve: [critical info]"` |
| Need to try alternative approach | `Esc + Esc` → restore code → try different prompt |

## Cheat Sheet

| Key / Command | Action |
|---|---|
| `Esc` | Stop Claude |
| `Esc + Esc` | Open rewind menu (checkpoints) |
| `Shift + Tab` | Toggle Plan Mode (think, don't execute) |
| `/compact` | Compress context |
| `/clear` | Clear history (CLAUDE.md preserved) |
| `/cost` | Check token usage |
| `/resume` | Continue previous session |
| `/mcp` | Check MCP server status |
| `/agents` | Manage subagents |
| `Shift + Enter` | New line in prompt |
