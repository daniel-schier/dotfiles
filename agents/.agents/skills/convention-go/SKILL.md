---
name: convention-go
description: >
  Go coding conventions for all repositories: layering and separation of
  concerns, constructors, types and interfaces, error handling, context,
  and test categorization. Apply when reading, writing, or reviewing Go
  code (*.go), or when deciding how to structure a Go package or test.
user-invocable: false
paths: ["**/*.go"]
---

# Go conventions

These rules apply to all Go code in the repository, across every component and
package.

All conventions follow [Effective Go](https://go.dev/doc/effective_go) and the
[Go Code Review Comments](https://go.dev/wiki/CodeReviewComments) unless this
document specifies otherwise.

`golangci-lint` is the source of truth for mechanically enforceable rules:
formatting, unused code, error-string style, shadowing. This document covers
the judgment calls a linter cannot make. Where the repository has a
`.golangci.yml`, it wins for mechanical checks. Where existing code already
follows a different local convention, stay consistent with it.

## Architecture and layering

Solid layering matters more than any single rule below.

- Each layer has one responsibility. Handlers parse and validate requests and
  shape responses; they hold no business logic. Services hold business logic
  and orchestrate; they touch neither transport nor SQL. Repositories handle
  persistence; they hold no business rules.
- Dependencies point inward. A handler depends on a service, a service on a
  repository. Inner layers never import outer layers.
- Do not skip a layer. If a layer would be a pure pass-through, collapse it
  rather than bypassing it from above.
- Add a layer when responsibilities actually separate, not before. At
  tenant-scale volumes a handler plus service, or handler plus store, is often
  enough. Introduce a repository interface when a second backend or a test
  seam needs it.

## Abstraction timing

- Decouple enough that an outside contributor can understand one part and
  replace it in isolation. Most of this code is open source, so optimize for
  the newcomer, not for hypothetical flexibility.
- Introduce an interface at the second implementation or the first real test
  seam, never on speculation.
- Prefer a concrete type until duplication or a test forces an abstraction.

## Variables

- Use descriptive names. Single-letter variables are acceptable only in
  well-established Go idioms: `w` for `http.ResponseWriter`, `r` for
  `*http.Request`, and loop variables in short-body range statements.
- Abbreviations are acceptable when unambiguous in context: `cfg` (config),
  `repo` (repository), `svc` (service), `mgr` (manager), `ttl`
  (time-to-live), `ctx` (context).
- Do not use `UPPER_SNAKE_CASE` for variables, even for values that are
  effectively constant at runtime.

```go
// correct
cfg := config.Load()
for _, e := range entries { ... }

// incorrect
CFG := config.Load()
for _, entry_item := range entries { ... }
```

## Constants

- Package-level constants use `camelCase` for unexported names and
  `PascalCase` for exported names. `UPPER_SNAKE_CASE` is not used anywhere.
- The following categories must always be extracted to named constants.
  Inline literals are not acceptable:

| Category | Example |
|---|---|
| HTTP route paths | `const pathSSEStream = "/api/v1/events/stream"` |
| HTTP status codes | Use `http.StatusConflict`, not `409` |
| MIME / media types | `const contentTypeProblemJSON = "application/problem+json"` |
| Cache key prefixes | `const cachePrefixPost = "post:"` |
| Cookie names and paths | `const refreshCookieName = "press_refresh"` |
| Time format strings | `const backupTimeFormat = "20060102_150405"` |
| Default sizes and limits | `const defaultMediaMaxUpload = 10 * 1024 * 1024` |
| Default durations | `const defaultRefreshTTL = 7 * 24 * time.Hour` |

```go
// correct
if resp.StatusCode() == http.StatusConflict { ... }
w.Header().Set("Content-Type", contentTypeProblemJSON)

// incorrect
if resp.StatusCode() == 409 { ... }
w.Header().Set("Content-Type", "application/problem+json")
```

## Functions

- Names are verb-noun phrases that express intent: `findUser`, `hashToken`,
  `mintAccessToken`, `sanitizeFilename`.
- Boolean predicate functions use a verb phrase that reads naturally in an
  `if` statement: `looksLikeUUID`, `wantsJSONOutput`.
- Constructor functions use the `New*` prefix: `NewHandler`, `NewManager`,
  `NewCache`.
- Middleware factory functions are named after the concern they enforce, as a
  noun: `CORS()`, `RealIP()`, `Redirects()`. No `New` prefix.
- Private helper functions follow the same verb-noun pattern, without an
  underscore prefix.
- Keep parameter counts at three or fewer. When a function needs more inputs,
  group related parameters into a struct.
- Avoid boolean parameters. A boolean flag usually means the function has two
  responsibilities and should be split.

```go
// correct
func NewHandler(deps Deps) *Handler { ... }
func looksLikeUUID(s string) bool { ... }

// incorrect
func CreateHandler(deps Deps, debug bool) *Handler { ... }
```

## Constructors

- Pass required collaborators in a `Deps` struct to `New*`. Use functional
  options only for optional tunables that have sensible defaults.
- Do not put required dependencies behind options. That hides what is
  mandatory to construct the type.
- Return `(*T, error)` only when construction can fail for reasons the caller
  cannot prevent at compile time: parsing config, compiling a template or
  regular expression, opening a connection. A constructor that only assembles
  wired dependencies returns `*T` and no error.
- Do not return an error to report a nil dependency. A missing dependency is a
  programming error; let it fail loudly at startup rather than threading a nil
  check through the API.

```go
// fallible construction
func NewRenderer(deps Deps) (*Renderer, error) {
    tmpl, err := template.ParseFS(deps.FS, "*.gohtml")
    if err != nil {
        return nil, fmt.Errorf("parse templates: %w", err)
    }
    return &Renderer{tmpl: tmpl}, nil
}

// optional tunable via functional option
func NewClient(deps Deps, opts ...Option) *Client { ... }
func WithTimeout(d time.Duration) Option { ... }
```

## Types and structs

- Type names are nouns that describe a single responsibility.
- Producers return concrete, exported types. A constructor returns
  `*UserService`, not an interface. Do not define an interface next to its
  sole implementation.
- Consumers declare the narrow interface they depend on, in the consumer
  package, limited to the methods that consumer actually calls. This is the
  "accept interfaces, return concrete types" rule.
- Per-constructor dependency bundles are named `Deps` and hold the
  consumer-defined interfaces, not concrete service types.

```go
// producer: internal/press/user.go
type UserService struct{ /* ... */ }

func NewUserService(deps Deps) *UserService { /* ... */ }

// consumer: internal/press/handler.go
type userFinder interface {
    FindUser(ctx context.Context, id string) (*User, error)
}

type Deps struct {
    Users userFinder
}

func NewHandler(deps Deps) *Handler { /* ... */ }
```

- Promote an interface to a shared, exported definition only when the same
  contract is consumed by more than one component and the method set is
  identical. Treat that as a deliberate exception, not the default.
- Context key types are unexported empty structs to prevent collisions:

```go
type contextKey struct{}
```

- Enum-like constant sets use a typed alias and an iota block:

```go
type Permission int

const (
    PermReadPublic Permission = iota
    PermUploadMedia
    PermReadOwn
)
```

## Packages

- Package names are all-lowercase, single words, no underscores or hyphens.
- Names reflect the domain, not the technical role: prefer `authctx` over
  `contexthelpers`, `rbac` over `permissions`.
- Avoid generic names as package names (the final segment of the import path):
  `util`, `common`, `helpers`, and `shared` are not acceptable. A package that
  needs one of these names lacks a clear responsibility and should be split or
  merged.
- Directory groupings under `internal/` may use organizational names when they
  group several component-agnostic packages. The package itself still gets a
  specific, domain-driven name.
- Code layout:
  - `pkg/`: generic, content-free utilities with no project semantics. Stable
    API, suitable for external reuse (`pkg/httpserver`, `pkg/retry`).
  - `internal/<component>/`: code owned by a single component
    (`internal/press/`, `internal/page/`, `internal/draft/`, `internal/clip/`).
  - `internal/shared/<package>/`: project-specific code consumed by more than
    one component but not generic enough for `pkg/`
    (`internal/shared/markdown/`).
  - Default to `internal/<component>/`. Promote to `internal/shared/` when a
    second component needs the code. Promote to `pkg/` only when the code is
    truly generic and you would publish it as a standalone library.

## Error handling

- Return errors; do not panic. Panic only for unrecoverable state, such as a
  programming error detected at startup.
- Add context when propagating. Wrap with `%w` to preserve the chain:

```go
if err != nil {
    return fmt.Errorf("load config: %w", err)
}
```

- Wrap with `%w` when the caller may need to inspect the underlying error.
  Return a fresh error without `%w` when the underlying error is an
  implementation detail the caller should not depend on.
- Define sentinel errors for conditions callers branch on. Test them with
  `errors.Is`, never by comparing strings:

```go
var ErrNotFound = errors.New("not found")
```

- Use a typed error (a struct implementing `error`) when the caller needs
  structured data from the failure. Test it with `errors.As`.
- Error string style (lowercase, no trailing punctuation) is linter-enforced.
  Do not restate it in review.

## Context

- A `context.Context` is the first parameter of a function, named `ctx`.
- Never store a Context in a struct. Pass it explicitly through the call chain.
- Do not pass a nil Context. Use `context.Background()` at the top level and
  `context.TODO()` only as a temporary placeholder.

## Logging and concurrency

These exist and are preferred, but the concrete choice belongs in an ADR or
with the maintainer. Recommend a pattern that fits the project scope rather
than imposing one.

- Prefer structured logging with `log/slog` over `fmt.Println` or an
  unstructured logger. Inject the logger as a dependency; avoid a package-level
  global.
- Give every goroutine a known lifecycle and a way to stop. Do not start a
  goroutine you cannot cancel. Propagate cancellation with context and respect
  `ctx.Done()`.
- For a group of related goroutines that can fail, prefer
  `golang.org/x/sync/errgroup` over a manual `WaitGroup` plus error plumbing.
- Add concurrency when a real need exists, not by default.

## Comments

- Write comments only when the why is non-obvious: a hidden constraint, a
  subtle invariant, or a workaround for a specific external bug.
- Do not comment what the code does. Well-named identifiers already express it.
- Do not leave task, fix, or caller references in comments
  (`// added for the auth flow`, `// TODO: remove when X is done`). These
  belong in commit messages and issue trackers.
- Exported symbols require a doc comment. Unexported symbols require one only
  when the reasoning behind the implementation is not obvious from reading it.

## Testing

Categorize every test before writing it. Run the whole suite with
`go test ./...`. The filename carries the category; do not use build tags for
this. End-to-end tests are out of scope for this convention: they vary too
much (hurl, Playwright, shell scripts) and are decided per project.

| Category | Boundary | Naming |
|---|---|---|
| `unit` | No real DB, network, filesystem, or clock. Fakes and stubs only. Includes `httptest` handler tests with stubbed dependencies. | `foo_test.go` |
| `integration` | Crosses one real boundary: DB, filesystem, or another service. | `foo_integration_test.go` |

An `httptest` plus `goquery` handler test with stubbed services is a unit
test. The recorder is in-memory and no real boundary is crossed. Routing
through `ServeHTTP` does not make it an integration test.

### Unit tests

- Mandatory for every function that contains logic. Test it in isolation.
- Cover the happy path, boundaries, and invalid or nonsense input (the "1
  beer, 2 beers, 3 beers, a lizard, toilet" range).
- Pure glue, wiring, and handlers often have no meaningful unit test. That is
  fine; cover them later with integration or end-to-end tests.
- Use table-driven tests for multiple cases of one function. Name each subtest
  so a failure points to the case: `t.Run(tc.name, func(t *testing.T) { ... })`.
- Test the exported API from an external `foo_test` package. Use the internal
  package only when a test needs unexported symbols.

### Writing tests that survive refactors

- Assert on observable behavior: return values, persisted state, emitted
  output. Do not assert on internal call order or call counts. Tests that pin
  implementation detail break on every refactor and cost more to repair than
  to rewrite.
- A test that needs changes when behavior has not changed is a smell. Rewrite
  it rather than nursing it through an incremental refactor.
- For a small abstraction surface (one or two methods, few consumers), write a
  hand fake. For a large interface or many consumers, generate doubles with
  `moq`. Prefer `moq` over `mockgen`: `moq` produces plain spy structs, while
  `mockgen` produces strict mocks that assert call sequences and reintroduce
  the brittleness above.

### Integration tests

- When code crosses a real boundary, do not write the integration test inline
  by default. Write the unit tests, leave a clearly flagged TODO, and call it
  out at the end of the implementation so the maintainer decides scope and
  depth.
- Guard any integration test so `go test -short` skips it:

```go
func TestUserRepo_integration(t *testing.T) {
    if testing.Short() {
        t.Skip("skipping integration test")
    }
    // ...
}
```
