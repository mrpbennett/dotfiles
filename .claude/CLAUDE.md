# CLAUDE.md

## GitHub Policy

**READ-ONLY** — Do not create, edit, or push anything to GitHub. No PRs, no commits, no issues. View/read operations only. This applies to `gh` CLI and any GitHub MCP tools. User will update this policy if write access is ever needed.

## File & Output Conventions

- All `.md` output files must be placed within a `docs/` directory — do not pollute the project root with loose Markdown files.
- Prefer pointers over copies: reference `file:line` rather than embedding code snippets that will become stale.

## Context & Memory Policy

Your context window will be automatically compacted as it approaches its limit, allowing you to continue working indefinitely. Therefore:

- Never stop tasks early due to token budget concerns.
- As you approach limits, save current progress and state to memory before the context refreshes.
- Be as persistent and autonomous as possible — complete tasks fully.

## Configuration Changes

When modifying existing configuration or keybinding systems, **extend the existing defaults** rather than replacing them from scratch. Always preserve existing functionality unless explicitly told to remove it.

## Workflow Orchestration

### Plan First

- Enter plan mode for any non-trivial task (3+ steps or architectural decisions).
- Write a plan to `tasks/todo.md` with checkable items before starting implementation.
- Write detailed specs upfront to reduce ambiguity.
- Check in with the user to verify the plan before building.
- If something goes sideways, **stop and re-plan immediately** — don't keep pushing.

### Track & Communicate

- Mark items complete in `tasks/todo.md` as you go.
- Provide a high-level summary at each step.
- Add a review section to `tasks/todo.md` when finished.

### Subagent Strategy

- Use subagents liberally to keep the main context window clean.
- Offload research, exploration, and parallel analysis to subagents.
- One task per subagent for focused execution.

## Verification Before Done

- Never mark a task complete without proving it works.
- Run tests, check logs, demonstrate correctness.
- Diff behavior between main and your changes when relevant.
- Ask yourself: "Would a staff engineer approve this?"

## Working Directory

**Stay in the directory where the session started.** Do not `cd` to another directory, and do not run commands that operate outside the starting working directory unless the user explicitly asks. Use absolute paths when referencing files in other locations — never navigate away. If a task seems to require leaving the project root, stop and ask the user first.

## Debugging Guidelines

Check the simplest environmental causes first (stale binaries, wrong repo, config override ordering) before diving into source code analysis. Ask clarifying questions if unsure.

## Self-Improvement Loop

- After any correction from the user, update `tasks/lessons.md` with the pattern.
- Write rules for yourself that prevent the same mistake recurring.
- Review lessons at session start for the relevant project.

## Core Principles

- **Simplicity First**: Make every change as simple as possible. Minimal code impact.
- **No Laziness**: Find root causes. No temporary fixes. Senior developer standards.
- **Minimal Impact**: Changes should only touch what's necessary. Avoid introducing bugs.
- **Demand Elegance (Balanced)**: For non-trivial changes, pause and ask "is there a more elegant way?" Skip this for simple, obvious fixes — don't over-engineer.
- **Autonomous Bug Fixing**: When given a bug report, just fix it. Point at logs, errors, failing tests — then resolve them. Zero context switching required from the user.

## Planning & Requirements

When creating plans or implementing features, capture **all** requirements from the user's description before starting. Store all data states (not just positive ones), include all framework options mentioned, and ensure every selected feature actually generates output.

## Linting & Formatting

Never manually enforce code style — use deterministic tools (linters, formatters) for that. Focus effort on logic, architecture, and correctness. If a linter or formatter is configured in the project, run it as a final step.

## Project-Specific Context

Before starting work in any project, look for a project-level `CLAUDE.md` or `docs/` directory for project-specific instructions (build commands, test runners, architecture notes, conventions). Read those first. If none exist and the task is non-trivial, explore the repo structure before making changes.
