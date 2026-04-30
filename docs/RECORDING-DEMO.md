# Recording the demo GIF

The README's hero GIF is a placeholder (`docs/screenshots/hook-blocks-commit.gif` does not yet exist). Replace it with a real recording of the commit-blocking hook in action — that single demo carries the value proposition more than the rest of the README combined.

## Bootstrap a clean demo project

Run [`docs/setup-demo-project.sh`](setup-demo-project.sh) — it creates `/tmp/cc-demo/` with a 5-file Python project containing one passing test, one failing test, the configs from this repo, and a one-commit `git log`. Everything is ready for recording.

```bash
bash docs/setup-demo-project.sh
cd /tmp/cc-demo
```

The script also prints the exact prompts to feed Claude during the recording.

## What the recording must show

A 6–12 second loop of:

1. Claude Code running `git commit -m "..."` at the user's prompt
2. The `[HOOK] Running tests before commit...` line appearing
3. `pytest` failing on a deliberately broken test
4. The hook printing `Tests are failing. Fix all test failures before committing.` and Claude refusing to proceed
5. (Optional) Claude reading the failure, fixing the test, retrying — second commit succeeds

## Recommended tool: asciinema → agg

`asciinema` records the terminal as plain text with timing metadata (small file, perfect resolution, terminal-native). `agg` converts it to GIF.

```bash
# install
brew install asciinema agg            # macOS
sudo apt install asciinema && cargo install --git https://github.com/asciinema/agg

# record
asciinema rec hook-demo.cast
# ... do the demo in this terminal ...
# Ctrl-D to stop

# convert to GIF
agg --theme monokai --rows 24 --cols 100 hook-demo.cast docs/screenshots/hook-blocks-commit.gif
```

## Alternative: OBS Studio + ffmpeg

If you want a fancier demo with cursor highlights and zoom, record the screen with [OBS](https://obsproject.com/), then convert:

```bash
ffmpeg -i recording.mkv -vf "fps=12,scale=900:-1:flags=lanczos,palettegen" palette.png
ffmpeg -i recording.mkv -i palette.png -filter_complex "fps=12,scale=900:-1:flags=lanczos[x];[x][1:v]paletteuse" docs/screenshots/hook-blocks-commit.gif
```

## Constraints

- **Keep it under 1 MB.** GitHub renders larger GIFs poorly on slow connections.
- **Loop seamlessly.** First and last frames should be visually identical (empty prompt).
- **No personal paths in view.** Run the demo from `/tmp/demo-project` or similar.
- **Use a fresh repo with two commits** so the `git log` shown is short and readable.

## Replacing the file

```bash
cp /path/to/your.gif docs/screenshots/hook-blocks-commit.gif
git add docs/screenshots/hook-blocks-commit.gif
git commit -m "Add hook-blocks-commit demo GIF"
```

The README already references this exact path — no Markdown edits needed once the file exists.
