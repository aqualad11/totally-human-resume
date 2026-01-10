# Modular Resume Builder (Typst)

A data-driven, modular resume system built with [Typst](https://typst.app/) and the [toy-cv](https://typst.app/universe/package/toy-cv/) template. Designed for easy customization by both humans and AI agents.

## Quick Start

```bash
# Compile the resume
typst compile resume.typ --font-path fonts/

# Watch for changes (auto-recompile)
typst watch resume.typ --font-path fonts/
```

## Project Structure

```
├── resume.typ          # Main Typst file (don't edit unless changing layout)
├── config.yaml         # Build configuration (sections, entry selection, theme)
├── data/
│   ├── personal.yaml   # Name, contact info, tagline
│   ├── experience.yaml # Work history
│   ├── education.yaml  # Degrees & certifications
│   ├── skills.yaml     # Skill categories
│   └── projects.yaml   # Personal/professional projects
├── fonts/              # Inter & Font Awesome 6 fonts
└── resume.pdf          # Generated output
```

## How to Customize

### For a Specific Job Application

1. **Edit `config.yaml`** to select which entries to include:

```yaml
sections:
  - skills
  - experience        # Section order
  - projects
  - education

include:
  experience:
    - ezoic-swe2      # Entry IDs to include
  projects:
    - universe-3d
    - print-service
```

2. **Optionally edit data files** to tweak highlights for relevance

3. **Compile**: `typst compile resume.typ --font-path fonts/`

### Adding New Entries

Add to the appropriate `data/*.yaml` file. Each entry needs a unique `id`:

```yaml
# data/experience.yaml
- id: new-job-id
  title: "Job Title"
  company: "Company Name"
  location: "City, State"
  start_date: "Month Year"
  end_date: "Present"
  highlights:
    - "Achievement or responsibility"
    - "Another bullet point"
  tags:
    - relevant-skill
    - another-tag
```

### Changing Theme Color

Edit `config.yaml`:

```yaml
theme:
  color: "#E40019"  # Any hex color
```

## For AI Agents

### What to Edit
- `config.yaml` — Control what appears and in what order
- `data/*.yaml` — Add/modify content entries

### What NOT to Edit
- `resume.typ` — Template logic (only if changing layout)
- `fonts/` — Required fonts

### Entry Selection
Use entry `id` values to include/exclude specific items:

```yaml
include:
  experience:
    - job-id-1
    - job-id-2
  projects:
    - project-id-1
```

Use `all` to include everything in a section:

```yaml
include:
  education: all
```

### Tags for Filtering
Each entry can have `tags` for semantic filtering based on job requirements:

```yaml
tags:
  - javascript
  - mentorship
  - cloud
```

## Requirements

- [Typst](https://typst.app/) CLI installed
- Fonts included in `fonts/` directory (Inter, Font Awesome 6)

## Template

This project uses the [toy-cv](https://typst.app/universe/package/toy-cv/) Typst template.
