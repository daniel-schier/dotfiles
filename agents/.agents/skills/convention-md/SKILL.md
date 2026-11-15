---
name: convention-md
description: >
  Markdown conventions for this repo: formatting (line length, lists, spacing)
  and writing style. Reference when writing or editing .md files.
user-invocable: false
paths: ["**/*.md"]
---

# Markdown conventions

This convention applies to all Markdown files in the repository.

## Formatting

The formatting rules apply in general. Before applying these rules, always
check if there is an existing formatting convention in the repository. These
can be found in lint files like `.markdownlint.yml` or `.prettierrc`.

- Wrap lines at 80 characters (prose only, never break links, tables, or code.)
- Unordered lists use -, never * or +
- Ordered lists use counting (e.g. 1., 2., 3.)
- One # (H1) per file, as the first line. Don't skip heading levels
- Headings in sentence case: "Getting started", not "Getting Started"
- Every fenced code block gets a language tag (go, bash, ...)
- One blank line before and after every list, heading, table, and fenced code
  block
- One blank line between paragraphs; never two or more in a row
- No trailing whitespace
- End the file with a single newline

The above rules can be broken if the existing content is otherwise formatted.
In that case, break them consistently with the rest of the content.

## Frontmatter

Identify if the file demands a frontmatter block. For example, if it is part
of a Jekyll, Hugo, or mkdocs site.

- Don't guess how to format the frontmatter
- Use the conventions defined in the site's documentation
- Don't use frontmatter for non-content files (e.g. configuration files)

## Templates

Format common markdown files as defined in the below table:

| Filename          | Template                                              |
|-------------------|-------------------------------------------------------|
| `README.md`       | `${CLAUDE_SKILL_DIR}/../../templates/README.md`       |
| `OPERATOR.md`     | `${CLAUDE_SKILL_DIR}/../../templates/OPERATOR.md`     |
| `ARCHITECTURE.md` | `${CLAUDE_SKILL_DIR}/../../templates/ARCHITECTURE.md` |
| `CONTRIBUTING.md` | `${CLAUDE_SKILL_DIR}/../../templates/CONTRIBUTING.md` |
| `DEVELOPER.md`    | `${CLAUDE_SKILL_DIR}/../../templates/DEVELOPER.md`    |
| `USER.md`         | `${CLAUDE_SKILL_DIR}/../../templates/USER.md`         |

## Writing style

- Active voice, present tense
- Imperative mood for steps and instructions ("Run the migration", not "You
  should run")
- Short: one idea per sentence; prefer short sentences over semicolons
- Self-contained: a reader shouldn't need to jump elsewhere to follow the doc
- Correct: examples must be runnable as-is: copy, paste, and they work
  (compile/execute without edits)
- Reference: use links to resources if details are not relevant to the document
- Define an acronym on first use, then use the short form
- No marketing or hype words ("seamless", "powerful", "blazing fast")
- Don't use em-dashes; use regular dashes for word breaks or reformulate
- Don't mix UK and US English spelling
