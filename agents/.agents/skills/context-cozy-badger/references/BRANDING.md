# Cozy Badger branding

## Identity and voice

- Write the company name as **Cozy Badger**. Use `cozybadgerde` for the
  organization handle, not as the display name.
- Keep the experience simple, convenient, and comfortable. These are the
  visual brand's keywords, complementing the company values in `SKILL.md`.
- Use warm, welcoming, reassuring language. Explain practical benefits in
  terms a non-technical business owner understands.
- Avoid jargon, hype, pressure, and unsupported promises. Friendly does not
  mean childish or imprecise.
- Follow the project's language and localization conventions. Do not infer
  an English-only or German-only policy from the company name or website.

## Color palette

Preserve these exact values and names from the supplied brand guidelines.

| Color | HEX | RGB |
|-------|-----|-----|
| Taupe | `#49382A` | `73, 56, 42` |
| Walnut Brown | `#564D43` | `86, 77, 67` |
| Linen | `#FCEFE6` | `252, 239, 230` |
| Feldgrau | `#3C4E38` | `60, 78, 56` |
| Tea Green | `#DBEDC2` | `219, 237, 194` |

- Favor the warm, muted palette rather than introducing unrelated brand colors.
- Reuse existing project color tokens. The guidelines do not assign semantic
  roles such as success, warning, or error to these colors.
- Verify contrast for the actual foreground, background, size, and state.
  A brand color is not automatically accessible in every combination.
- Do not rely on color alone to communicate status or required actions.

## Typography

| Role in guidelines | Typeface | Listed weights |
|--------------------|----------|----------------|
| Primary | Signika | Regular, Medium, Semibold, Bold |
| Secondary | Poppins | Regular, Medium, Bold, Black |

- Reuse the project's font setup and fallback stack.
- Preserve these families when implementing company branding. The guidelines
  do not mandate an exclusive heading/body assignment.
- Ask before replacing fonts or adding a font provider or dependency.
- Do not rebuild the logo wordmark as live text.

## Logos

- Reuse approved assets. Do not redraw the badger, generate a replacement,
  stretch, rotate, crop, or rearrange the symbol and wordmark.
- Available asset families are symbol-only, horizontal, vertical, and black
  versions on transparent backgrounds. Select a layout that fits the space.
- Colored assets have variants V1 through V4. Inspect the asset and background;
  do not assume a version number denotes priority or a default.
- Preserve the asset's proportions, colors, and internal spacing. Choose an
  existing variant that remains legible on the intended background.
- Keep text and other elements outside the logo's clear space. The horizontal
  construction diagram shows `2x` outer clearance, with `x` the word-space
  unit in that diagram. Do not reinterpret this as two pixels or two logo
  widths, or invent a minimum size not specified by the guidelines.
- Check readability at the actual rendered size. Give a meaningful logo
  appropriate alternative text; mark redundant decorative instances as such.
- Prefer assets already in the current project's approved asset directory.
  The skill's reusable SVG originals are in [logos](../assets/logos/), grouped into
  `Logo [Colored]`, `Logo [Horizontal]`, `Logo [Vertical]`, and
  `Logo [Transparent]`.
- If project assets are absent, select an appropriate original and confirm
  the destination before copying it into the project. Do not make project
  code depend on the skill's filesystem location.

## Source and limits

Derived from the owner-supplied
[Brand Guidelines - Cozy Badger (2024)](../assets/brand-guidelines.pdf): brand values,
color palette, logo design, typography, and application examples.
The selected logo concept is the middle concept, not the rejected alternatives.

Use this summary for routine work. Consult the PDF for visual construction,
clear-space diagrams, and application examples; inspect the SVG originals
when selecting a logo.

The guidelines do not define complete interface tokens, dark-mode behavior,
font hosting, or minimum logo sizes. Preserve established project decisions;
ask when a new decision is needed.
