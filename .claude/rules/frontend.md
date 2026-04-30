---
globs: ["**/*.{js,jsx,ts,tsx,vue,svelte}"]
---

# Frontend Rules

> Loaded automatically when Claude opens any frontend source file. Each rule has a "why" so you can override it intentionally.

## Components
- Functional components only (no class components) — *hooks API is the supported path since React 16.8 (2019); class lifecycle methods are not first-class with Suspense / concurrent rendering*
- One component per file — *grep-by-filename works; circular-import risk drops*
- Reusable components in `components/`, page components in `pages/` or `views/` — *next.js / nuxt convention; routing tools depend on it*
- Props interface/type defined at top of file (TS) or `propTypes` defined at bottom (JS) — *contract is visible without scrolling; LSP autocomplete works for consumers*

## State Management
- Local state for component-specific data (`useState`, `useReducer`) — *keep blast radius small; don't pollute global store with form input state*
- Global store (Zustand / Redux / Pinia) for shared application state only — *anything passed through more than 2 prop layers is a candidate; below that, prop drilling is fine*
- API calls through a dedicated service layer (`services/` or `api/`), not inside components — *one place to swap fetch for axios, add retries, mock in tests*
- Loading and error states for all async operations — *the "spinner-then-blank" UX is a regression magnet; always render `if (error) ... if (loading) ... return data`*

## Styling
- Follow the project's existing convention (CSS modules / Tailwind / styled-components / vanilla-extract) — *do not introduce a second styling system; the bundle size and cognitive cost is real*
- Responsive design — mobile-first (`min-width` queries, not `max-width`) — *progressive enhancement; default styles work on the smallest target*
- No inline styles beyond trivial cases (one-off `style={{ width: dynamicPx }}`) — *inline styles bypass the design system, can't be themed, and hurt CSP*

## Error Handling
- Error boundaries for user-facing component trees — *uncaught render errors otherwise unmount the entire React tree (white screen)*
- User-friendly error messages, no raw `error.toString()` — *expose stack traces only in dev; production users see a sentence and a retry button*
- Graceful degradation when API is unavailable — *show cached data + "offline" indicator rather than a hard error*

## Testing
- Unit tests for utility functions (Vitest / Jest) — *fastest feedback loop; pure functions deserve 100% coverage*
- Component tests for user interactions (Testing Library: `getByRole`, `userEvent.click`) — *test the user contract, not implementation details; avoid `getByTestId` unless nothing semantic exists*
- Mock API responses in tests (MSW preferred over `jest.mock`) — *MSW intercepts at the network layer, so the same mocks work in Storybook and Playwright*
- Test accessibility (semantic HTML, ARIA labels, `getByRole` queries) — *if Testing Library can find your button, so can a screen reader*
