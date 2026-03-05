---
globs: ["**/*.py"]
---

# Python Backend Rules

## Code Style
- Type hints on ALL function signatures (parameters and return types)
- Docstrings on all public functions and classes (Google style)
- Use `pathlib.Path` instead of `os.path`
- Prefer f-strings over `.format()` or `%`
- Use `logging` module, never `print()` for non-debug output
- Constants in UPPER_SNAKE_CASE at module level

## Error Handling
- Handle exceptions explicitly — never use bare `except:`
- Use custom exception classes for domain errors
- Always log exceptions with traceback: `logger.exception("message")`
- Return meaningful error messages to API callers

## Architecture
- Use Pydantic models for request/response validation
- Async endpoints where I/O is involved
- Dependency injection for testability
- Repository pattern for database access
- Service layer between routes and repositories

## Testing
- Use pytest with fixtures
- Mock external services (API calls, database) in unit tests
- Use factories for test data (not hardcoded dictionaries)
- Async tests with `pytest-asyncio`
- Each test function tests ONE thing
