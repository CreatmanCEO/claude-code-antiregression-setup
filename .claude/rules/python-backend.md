---
globs: ["**/*.py"]
---

# Python Backend Rules

> Loaded automatically when Claude opens any `*.py` file. Each rule has a "why" so you can override it intentionally rather than blindly.

## Code Style
- Type hints on ALL function signatures (parameters and return types) — *enables `mypy --strict` and IDE autocomplete; required by FastAPI/Pydantic v2 for response_model inference*
- Docstrings on all public functions and classes (Google style) — *parsed by Sphinx/mkdocstrings; downstream callers see hover hints*
- Use `pathlib.Path` instead of `os.path` — *cross-platform paths, chainable API, `.exists()`/`.read_text()` without import gymnastics*
- Prefer f-strings over `.format()` or `%` — *fastest path on CPython 3.12+; lower cognitive load*
- Use `logging` module, never `print()` for non-debug output — *level filtering, structured handlers, captured by pytest's `caplog` fixture*
- Constants in UPPER_SNAKE_CASE at module level — *grep-friendly, distinguishable from runtime values*

## Error Handling
- Handle exceptions explicitly — never use bare `except:` — *bare except swallows `KeyboardInterrupt` and `SystemExit`, hides real bugs*
- Use custom exception classes for domain errors — *callers can `except DomainError` without coupling to library-specific exception types*
- Always log exceptions with traceback: `logger.exception("message")` — *not `logger.error(str(e))` which loses the stack*
- Return meaningful error messages to API callers — *FastAPI: prefer `HTTPException(status_code, detail)` over generic 500*

## Architecture
- Use Pydantic v2 models for request/response validation — *catches malformed input at the boundary; auto-generates OpenAPI*
- Async endpoints where I/O is involved (`await db.execute(...)`, `await http.get(...)`) — *sync handlers block the event loop and serialise the entire app*
- Dependency injection (FastAPI `Depends`) for testability — *swap real DB session for in-memory in tests without monkey-patching*
- Repository pattern for database access — *isolates SQL/ORM details from business logic; one place to add caching*
- Service layer between routes and repositories — *route handlers stay thin (parse → call service → serialise); business logic is unit-testable without HTTP*

## Testing
- Use pytest with fixtures (not `unittest.TestCase`) — *first-class parametrize, smaller boilerplate, plugin ecosystem (`pytest-asyncio`, `pytest-mock`, `pytest-cov`)*
- Mock external services (API calls, database) in unit tests — *unit tests must run in <1 s each; integration tests live in a separate folder*
- Use factories for test data (`factory_boy`, `polyfactory`), not hardcoded dictionaries — *changes to a model don't break 50 unrelated tests*
- Async tests with `pytest-asyncio` and `@pytest.mark.asyncio` — *required for `async def` tests; otherwise pytest treats them as coroutines and skips silently*
- Each test function tests ONE thing — *failure message names exactly what regressed; no shotgun debugging*
