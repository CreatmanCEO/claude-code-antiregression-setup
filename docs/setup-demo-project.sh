#!/usr/bin/env bash
#
# Bootstraps a tiny demo project ready to record the hero GIF.
# Run from the root of claude-code-antiregression-setup.
#
# Usage:
#   bash docs/setup-demo-project.sh
#   cd /tmp/cc-demo
#   asciinema rec hook-demo.cast
#   # ... record the demo (instructions below) ...
#
# Recording script (paste these prompts/commands one at a time):
#   1. claude
#   2. > Read CLAUDE.md and tell me what this project does in one sentence.
#   3. > Now run:  git add -A && git commit -m "feat: add divide function"
#      Claude will execute the git commit. The PreToolUse hook will run
#      pytest, see test_divide_by_zero fail, and BLOCK the commit.
#   4. > Look at the failure, fix the divide function to handle zero,
#      and try the commit again.
#   5. Claude fixes calculator.py, retries the commit, hook passes, commit succeeds.
#
# Total recording length: ~25 seconds. Trim to ~12 seconds in the GIF.

set -euo pipefail

DEMO_DIR="${DEMO_DIR:-/tmp/cc-demo}"
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

if [ -e "$DEMO_DIR" ]; then
  echo "ERROR: $DEMO_DIR already exists. Remove it first or set DEMO_DIR=/some/other/path." >&2
  exit 1
fi

mkdir -p "$DEMO_DIR"
cd "$DEMO_DIR"

# Copy the anti-regression configs in
cp -r "$REPO_ROOT/.claude" .
cp "$REPO_ROOT/CLAUDE.md.template" CLAUDE.md
mkdir -p plans tests

# Fill in CLAUDE.md with demo-project specifics
cat > CLAUDE.md <<'CLAUDE_EOF'
# Calculator Demo

## Architecture
- **Language**: Python 3.12
- **Tests**: pytest

## Key Commands
- `python -m pytest tests/` — Run test suite

## CRITICAL RULES — MUST FOLLOW
- **NEVER** delete or rewrite working tests without explicit request
- **ALWAYS** run tests after any code change
- One task at a time. Complete and verify before moving to next
CLAUDE_EOF

# A working module
cat > calculator.py <<'CALC_EOF'
def add(a: float, b: float) -> float:
    return a + b


def divide(a: float, b: float) -> float:
    return a / b
CALC_EOF

# A passing test and a deliberately failing test
cat > tests/test_calculator.py <<'TEST_EOF'
import pytest
from calculator import add, divide


def test_add():
    assert add(2, 3) == 5


def test_divide():
    assert divide(10, 2) == 5


def test_divide_by_zero():
    """divide(x, 0) must raise ValueError, not ZeroDivisionError."""
    with pytest.raises(ValueError, match="cannot divide by zero"):
        divide(10, 0)
TEST_EOF

# Initial git state — important so `git log` is short during recording
git init --quiet
git add -A
git commit --quiet -m "Initial calculator with one failing test"

cat <<MSG

Demo project ready at: $DEMO_DIR

Next steps:
  cd $DEMO_DIR
  asciinema rec hook-demo.cast
  # then in the recorded session:
  #   claude
  #   > Run: git add -A && git commit -m "stub: ship divide function"
  #   (hook blocks → claude fixes calculator.py → commits again → passes)
  # press Ctrl-D to stop recording

Convert to GIF:
  agg --theme monokai --rows 24 --cols 100 hook-demo.cast \\
      $REPO_ROOT/docs/screenshots/hook-blocks-commit.gif

Then commit the GIF:
  cd $REPO_ROOT
  git add docs/screenshots/hook-blocks-commit.gif
  git commit -m "Add hero GIF: hook blocking a failing commit"
  git push

Tip: keep the GIF under 1 MB. If too large:
  agg --rows 22 --cols 90 --speed 1.4 hook-demo.cast ...
MSG
