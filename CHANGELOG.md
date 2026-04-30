# Changelog

All notable changes to this project will be documented in this file.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) · [SemVer](https://semver.org/spec/v2.0.0.html).

## [0.2.0] — 2026-04-30

### Added
- Mermaid diagram of the four-layer defence model in `README.md`
- `Limitations & honest disclaimers` section covering compaction, subagent isolation, shell portability, slow suites, push-vs-commit gate, `/clear` behaviour, advisory nature of rules
- `Tech stack & component map` table mapping each file to a concrete role
- `Configuration notes` section explaining `permissions.allow` semantics and stack-specific test-command swap-ins
- `CHANGELOG.md` (this file)
- `CONTRIBUTING.md` with priority list for community submissions
- `.github/workflows/validate.yml` — validates `settings.json` is well-formed JSON and every agent file has a YAML frontmatter `name:` field
- "Featured on Habr / dev.to / Claude Code Opus 4.7" badges
- Inline `CRITICAL RULES` block in `README.md` so the value proposition is visible without opening the template
- "Why" rationale comments on rules in `.claude/rules/python-backend.md` and `.claude/rules/frontend.md`
- Author signature with full name and direct links to Habr / dev.to profiles

### Changed
- README hero rewritten: leads with social proof (Habr top-5, 20K reads, Технотекст 8) and Opus 4.7 / 1M context positioning
- "The Problem" section replaced with the post-1M-context narrative — regressions are a discipline problem, not a memory problem
- Project structure tree annotated with concrete responsibilities per file
- `Recommended stack` table extended with "Why" column

### Notes on `settings.json`
- `Bash(pip install*)` remains in `permissions.allow` for compatibility with the original community template, but is now flagged in README as a candidate for removal in security-sensitive projects
- The hook's `pytest` command is unchanged; README now documents the npm / cargo / go variants

## [0.1.0] — 2026-03-05

### Added
- Initial release accompanying the [Habr article](https://habr.com/ru/articles/1013330/) (top-5 day, 20K reads, Технотекст 8 entry) and the [dev.to article](https://dev.to/creatman/i-stopped-claude-code-from-breaking-my-projects-heres-the-exact-setup-1agi)
- `CLAUDE.md.template` with `CRITICAL RULES`, `Working Style`, `Agents`, `Known Patterns`, `Gotchas` sections
- `.claude/settings.json` with `PreToolUse` commit-blocking `pytest` hook and `PostToolUse` edit reminder
- Three subagents: `planner` (research-only, no `Write` tool), `tester` (full-suite runner with regression check), `code-reviewer` (severity-tagged review)
- Two glob-scoped rules: `python-backend.md` (`**/*.py`), `frontend.md` (`**/*.{js,jsx,ts,tsx,vue,svelte}`)
- `docs/WORKFLOW.md` daily playbook with emergency recovery and cheat sheet
- `docs/MCP-SETUP.md` for Playwright, GitHub, Postgres, Context7
- `LICENSE` (MIT)
