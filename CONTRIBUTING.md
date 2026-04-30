# Contributing

Thanks for considering a contribution. This repo is intentionally small — its job is to be a clean, copy-paste starter for Claude Code anti-regression configs. PRs that add real, battle-tested artifacts are very welcome.

## Priorities (highest impact first)

1. **Sister rules for new languages** — `.claude/rules/go-backend.md`, `rust-backend.md`, `typescript-node.md`, `kotlin.md`, etc. Follow the existing `python-backend.md` shape (frontmatter `globs:` + sections + a one-line "why" per rule).
2. **Framework-specific subagents** — `django-tester.md`, `nextjs-reviewer.md`, `rails-planner.md`. Constrain `tools:` to the minimum set needed and document the output format.
3. **Additional `PreToolUse` hooks** — examples that would fit:
   - **Lint gate** on `git commit*` (`ruff check` / `eslint` / `golangci-lint`)
   - **Secret-scanning gate** on `git commit*` (`gitleaks detect --staged`)
   - **Migration-safety gate** on writes to `migrations/` directory
4. **Stack-specific test-command swap-ins** for the README's `Configuration notes` section (Maven, Gradle, sbt, mix, etc.).
5. **Recording assets** — better demo GIF / asciinema cast than the placeholder.

## What we will not merge

- "Best practices" essays without code artifacts.
- Vendor-specific rules that lock the user into a single editor or shell beyond what the existing setup already does.
- Hooks that silently weaken the commit gate (e.g. `pytest --pass-with-no-tests` without a clear opt-in note).
- Generic linter configs that already have canonical homes elsewhere (just link to them in `docs/MCP-SETUP.md` style).

## Pull request checklist

- [ ] New rule file has frontmatter `globs:` and at least one "why" rationale per bullet
- [ ] New subagent has `name:`, `description:`, `tools:` frontmatter and an explicit output format
- [ ] New hook has a stated **timeout**, a stated **shell** (bash / pwsh / cross-platform), and a tested failure path
- [ ] `README.md` and `CHANGELOG.md` updated when surface area changes
- [ ] `validate.yml` workflow still passes (it checks `settings.json` is valid JSON and every `.claude/agents/*.md` has a `name:` frontmatter field)

## Style

- Prefer concrete commands and version numbers over abstract advice.
- One sentence per rule. If you need a paragraph, you are explaining the wrong thing.
- Cite the source of any "best practice" you import (Anthropic docs, SFEIR Institute, real incident).

## Author / maintainer

[@CreatmanCEO](https://github.com/CreatmanCEO) — Nick Podolyak. Open an issue first for anything larger than a single rule or subagent.
