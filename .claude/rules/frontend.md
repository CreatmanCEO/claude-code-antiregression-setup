---
globs: ["**/*.{js,jsx,ts,tsx,vue,svelte}"]
---

# Frontend Rules

## Components
- Functional components only (no class components)
- One component per file
- Reusable components in `components/` directory
- Page components in `pages/` or `views/` directory
- Props interface/type defined at top of file

## State Management
- Local state for component-specific data
- Global store for shared application state
- API calls through dedicated service layer (not inside components)
- Loading and error states for all async operations

## Styling
- Follow existing project conventions (CSS modules / Tailwind / styled-components)
- Responsive design — mobile-first approach
- No inline styles beyond trivial cases

## Error Handling
- Error boundaries for user-facing components
- User-friendly error messages (no raw error objects)
- Graceful degradation when API is unavailable

## Testing
- Unit tests for utility functions
- Component tests for user interactions
- Mock API responses in tests
- Test accessibility (semantic HTML, ARIA labels)
