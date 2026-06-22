# Keymap Review & Improvement Spec

Synthesis of two independent reviews of `keymap.json` against LazyVim defaults and current Zed action surface. Reviewers: `Code Reviewer` (grounded in fetched Zed docs) + `superpowers:code-reviewer` (structural/spec lens).

**Status:** Spec only. No changes to `keymap.json` until approved.

---

## TL;DR

The file is a solid LazyVim-flavored skeleton but has **3 correctness bugs that silently break bindings**, ~25 high-value LazyVim defaults missing, and several places where you're shelling out to tasks for things Zed has native actions for. Highest-ROI fixes first below.

---

## 1. Critical bugs — must fix

### C1. `space c r` rename is dead — trailing space
**`keymap.json:89`** — `"space c r "` is parsed with a 4th empty token; never fires.
```json
"space c r": "editor::Rename",
```
This is the most-used LSP binding in LazyVim and currently does nothing.

### C2. Unscoped block at the bottom is a global footgun
**`keymap.json:255–262`** — no `context` field means it fires *everywhere*, including terminals, search bars, the agent panel, and inside text inputs. It's also a strict duplicate of the editor-scoped binding at line 161.
**Fix:** delete the block. The line 161 + line 76 (EmptyPane) bindings already cover both situations.

### C3. `VimControl && !menu` block hijacks `n`/`N` after `f`/`t`
**`keymap.json:201`** — the block remaps `n`/`shift-n` to `n z z z v` via `SendKeystrokes`. Without `!VimWaiting`, after pressing `f`/`t`/`F`/`T` the next `n` keystroke (which should jump *to character n*) gets captured. Also: `g r` → `editor::FindAllReferences` and `ctrl-d/u` recentering are editor-only but the current scope also matches Terminal/Dock VimControl contexts.

**Fix:** change context to match line 86:
```json
{ "context": "Editor && VimControl && !VimWaiting && !menu", "bindings": { ... } }
```

> **Reviewer disagreement on action names:** `superpowers:code-reviewer` flagged `editor::GoToPreviousHunk`, `editor::GoToPreviousDiagnostic`, `pane::AlternateFile`, and `assistant::InlineAssist` as suspect. `Code Reviewer` confirmed all are currently valid by grounding in fetched Zed docs. Trust the doc-grounded result — but `assistant::*` vs `agent::*` is genuinely inconsistent (you use both in the same file: `agent::ToggleFocus` line 91, `assistant::InlineAssist` lines 94–95). Standardize when Zed deprecates one.

---

## 2. LazyVim parity gaps — high-value additions

All snippets below go in the existing `Editor && VimControl && !VimWaiting && !menu` block at line 86 unless noted.

### `g*` LSP motions — only `gr` is bound
LazyVim universal defaults; you have `gr` (line 208) but none of:
```json
"g d": "editor::GoToDefinition",
"g D": "editor::GoToDeclaration",
"g I": "editor::GoToImplementation",
"g y": "editor::GoToTypeDefinition",
```
*Note:* `K` for hover is already provided by Zed's vim mode — don't rebind it.

### `<leader>w h/j/k/l` — pane nav by leader
You have `<C-hjkl>` already; LazyVim binds both. Add:
```json
"space w h": "workspace::ActivatePaneLeft",
"space w j": "workspace::ActivatePaneDown",
"space w k": "workspace::ActivatePaneUp",
"space w l": "workspace::ActivatePaneRight",
```

### `<leader>g*` — git namespace is mostly empty
Present: `g b` (147), `gh d/D/r/R` (97–100), `g g` lazygit (238). Missing the heavyweights:
```json
"space g s": "git_panel::ToggleFocus",      // git status panel
"space g c": "git::Commit",
"space g p": "git::Push",
"space g P": "git::Pull",
"space g f": "git::Fetch",
"space g a": "git::StageAll",
"space g u": "git::UnstageAll",
"space g o": "git::OpenModifiedFiles",      // opens every modified file as tabs
"space g m": "git::GenerateCommitMessage"
```

### `<leader>x` diagnostics namespace — entirely missing
LazyVim idiom. You have `space s d` (line 150); add the LazyVim alias:
```json
"space x x": "diagnostics::Deploy"
```
Most other `<leader>x*` (quickfix, location list) has no Zed analogue — document the gap rather than over-mapping.

### `<leader>b` — buffer namespace divergences
- **Line 133:** `space b q` → `pane::CloseOtherItems`. LazyVim's "close others" is `<leader>bo`, not `bq`. Rebind for parity.
- **Line 135:** `space b n` → `workspace::NewFile`. Not a LazyVim binding; collides semantically with `space f n` (line 143). Drop.

```json
"space b o": "pane::CloseOtherItems",       // LazyVim parity (replaces space b q)
"space b p": "pane::TogglePinTab"           // LazyVim <leader>bp
```

### `<leader>s` search additions
Present: `s w/W/g/b/d/s`. Missing:
```json
"space s S": "project_symbols::Toggle",                            // workspace symbols
"space s r": ["pane::DeploySearch", { "replace_enabled": true }]   // search & replace
```

### `<leader>f` find additions
Present: `f n/p/t/f`. Missing:
```json
"space f r": "projects::OpenRecent",        // recent (aliased to fp; LazyVim distinguishes)
"space f b": "tab_switcher::Toggle"         // open buffers picker
```

### `]]` / `[[` reference navigation
```json
// In the VimControl && !menu block (after the C3 fix):
"] ]": "vim::GoToNextReference",
"[ [": "vim::GoToPreviousReference"
```

### `<leader>w d` semantic mismatch
**Lines 174–175** — both `space w c` and `space w d` → `pane::CloseAllItems`. LazyVim's `<leader>wd` is "delete window" (close split). Zed has no `pane::Close`; closing all items collapses the split as a side effect, so `pane::CloseAllItems` is the closest fit. Drop the duplicate `space w c` and replace with something useful, or leave as-is and accept the redundancy.

---

## 3. Zed-native improvements over current bindings

### `task::Spawn` for file/grep is a roundabout — verify intent
**`keymap.json:76, 139, 157, 161, 257`** all shell out to a custom task for finding/searching. Zed has native:
```json
"space f f": "file_finder::Toggle",
"space space": "file_finder::Toggle",
"space s g": "pane::DeploySearch"
```
**Decision needed from you:** if your `file_finder`/`grep_search` tasks invoke fzf/telescope/ripgrep with custom UX you specifically want, keep them and add a comment explaining why. Otherwise switch to native — they're faster and integrate with Zed's vim mode. Same goes for the EmptyPane copy at lines 76–79.

### `space s b` → `vim::Search` is semantically off-LazyVim
**`keymap.json:137`** — LazyVim's `<leader>sb` is a fuzzy picker over **buffer lines**. `vim::Search` opens the `/` prompt, which is different. If you want LazyVim parity, use `buffer_search::Deploy` (which is what `space s w` at line 111 already uses). If you want the `/` prompt, rename the binding to e.g. `space s /` to avoid confusion.

### `cmd-k` shadows Zed's chord prefix
**`keymap.json:30, 93`** — bound to `workspace::ToggleRightDock` in `AgentPanel` and editor contexts. Zed's default `cmd-k` is a chord prefix (`cmd-k cmd-s` → keymap, `cmd-k v` → markdown preview). You're shadowing it in those contexts. Probably intentional, but worth a comment so future-you doesn't wonder why chords don't work.

### `ctrl-6` for alt-file
**`keymap.json:64`** — vim convention is `ctrl-^`. Zed accepts both, but verify it fires on your layout. If not, swap to `ctrl-^`.

---

## 4. Structural cleanup

### Duplicates worth deleting
- **`keymap.json:168`** — `space f t` already bound at line 6 (Workspace context covers Editor via ancestry). Delete.
- **`keymap.json:135`** — `space b n` (see §2). Delete.
- **`keymap.json:174` or `175`** — `space w c`/`w d` collision (see §2). Pick one.
- **`keymap.json:255–262`** — unscoped block (see C2). Delete.

### Reorganize for findability
The big editor block at lines 85–190 mixes leader namespaces. `space b *` is split across 129/131/133/135 with `space ,` (127) between them; `space f *` is at 109/143/157/168. Add section comment banners:
```json
// --- <leader>f: find/file ---
// --- <leader>s: search ---
// --- <leader>g: git ---
// --- <leader>b: buffer ---
// --- <leader>w: window ---
// --- <leader>c: code/LSP ---
// --- <leader>u: UI toggles ---
// --- <leader>x: diagnostics ---
```
…and group bindings under their banner. Order banners alphabetically by leader letter.

### Comments worth fixing
- **Line 33:** `// File panel (netrw)` — Zed's project panel isn't netrw. Misleading.
- **Lines 177–185:** the `]h`/`]c` and `]d`/`]e` pairs each map two keys to the same action. Intentional (LazyVim `]e` is errors-only; Zed doesn't filter by severity), but worth a comment.
- **Line 124:** `space 0` → `ActivateLastItem` is "last visited" not "tenth tab." Easy to forget.

### `q` → close pattern
**Line 23** has `q: git_panel::Close` in the `GitPanel` context. Consider adding the same vim-flavored close in `AgentPanel` (lines 27–32) for consistency.

---

## 5. Nice-to-haves (lower priority)

### Visual-mode indent-stay-selected
The near-universal Neovim mod LazyVim doesn't ship by default but most users add:
```json
// In the visual-mode block (line 192):
"<": ["workspace::SendKeystrokes", "< g v"],
">": ["workspace::SendKeystrokes", "> g v"]
```

### `<S-h>` / `<S-l>` for buffer prev/next
LazyVim's most-used buffer nav. Overrides vim's `H`/`L` cursor-screen motions:
```json
// In VimControl && !menu (after C3 fix):
"shift-h": "pane::ActivatePreviousItem",
"shift-l": "pane::ActivateNextItem"
```

### `<C-s>` save in any mode
```json
{ "context": "Editor", "bindings": { "ctrl-s": "workspace::Save" } }
```

### `<leader>?` discoverability stand-in
Zed has no which-key. Closest is the command palette (already on `cmd-shift-p`):
```json
"space ?": "command_palette::Toggle"
```

---

## 6. Acknowledged gaps Zed itself causes

LazyVim namespaces with no good Zed analogue — don't try to force these:
- **`<leader>q*`** sessions (Zed has no session manager)
- **`<leader>u*`** UI toggles — Zed exposes very few toggle actions (no `ToggleLineNumbers`, no `ToggleRelativeLineNumbers`, no `ToggleAutoFormat` as public actions). Code Reviewer confirmed these don't exist; do not add bindings for them.
- **`<leader>x*`** location list / quickfix beyond `xx` — Zed's multibuffer excerpts are the analogue but use different UX
- **`<leader>cR`** rename file — no public Zed action

---

## ROI ranking — do these in order

1. **C1** — fix `space c r` trailing space. *5 seconds, restores rename.*
2. **C2** — delete the unscoped block at 255–262. *Removes a global footgun.*
3. **C3** — add `Editor &&` and `!VimWaiting` to line 201. *Fixes `n`/`N` after `f`/`t`.*
4. Add `g d`/`g D`/`g I`/`g y` LSP motions.
5. Add `space w h/j/k/l` pane nav.
6. Add the `space g *` git family.
7. Replace `task::Spawn` file/grep shell-outs with native — *only if not deliberate*.
8. Rebind `space b q` → `space b o` for LazyVim parity; add `space b p`.
9. Drop duplicates: `space f t` (168), `space b n` (135), one of `space w c`/`w d`.
10. Add `space x x`, `space s S`, `space s r`, `space f r`, `space f b`, `]]`/`[[`.
11. Reorganize into namespace-banner sections.
12. Nice-to-haves (§5).

---

## Decisions — resolved

1. **`task::Spawn` `file_finder`/`grep_search`** — **KEEP**. Deliberately custom. Will add a `// Custom: ...` comment block above the bindings explaining why so future-you doesn't switch them.
2. **`space w c` vs `space w d`** — **DROP `space w c`**. Keep only `space w d` → `pane::CloseAllItems` (LazyVim parity).
3. **`space s b`** — **REBIND to `buffer_search::Deploy`**. Reasoning: line 111 already uses `buffer_search::Deploy` with cursor-word semantics (search word under cursor); calling it from `space s b` without context opens an empty search bar — closest Zed has to LazyVim's buffer-lines picker. The vim `/` prompt is still available via the default vim-mode `/` key, so nothing is lost. Update the comment on line 137 from "Search in the current buffer" to "Buffer-lines search (LazyVim <leader>sb)".
4. **`shift-h` / `shift-l`** for buffer prev/next — **YES**. Opinionated override of vim's `H`/`L` cursor-screen motions accepted. Add to the `Editor && VimControl && !VimWaiting && !menu` block (after C3 fix).
5. **`agent::*` vs `assistant::*`** — **STANDARDIZE on `agent::*`**. Zed is migrating that direction and `agent::ToggleFocus` is already in use (line 91). Caveat: I have not verified `agent::InlineAssist` exists as the new name — before flipping lines 94–95, open the command palette in Zed, search for "InlineAssist", and confirm the canonical namespace. If the palette only returns `assistant::InlineAssist`, leave those two lines alone for now.

---

## Final action plan (ordered)

Apply in this order. Each step is independently testable.

### Step 1 — Critical bug fixes (no parity changes)
- Fix `space c r ` trailing space → `space c r` at line 89.
- Delete unscoped block at lines 254–262 (the leading `{` is on 254 in the current file — check `}` placement).
- Change context at line 201 from `"VimControl && !menu"` to `"Editor && VimControl && !VimWaiting && !menu"`.

### Step 2 — Drop duplicates
- Delete `space f t` duplicate at line 168 (already covered by Workspace block at line 6).
- Delete `space b n` at line 135 (not LazyVim, collides with `space f n`).
- Delete `space w c` at line 174 (per decision #2).

### Step 3 — Rebind divergences for LazyVim parity
- Line 133: rename `space b q` → `space b o` (LazyVim "close others" is `<leader>bo`).
- Line 137: rebind `space s b` from `vim::Search` to `buffer_search::Deploy` and update comment.

### Step 4 — Add LazyVim parity bindings (in existing line-86 editor block)

```jsonc
// --- LSP motions ---
"g d": "editor::GoToDefinition",
"g D": "editor::GoToDeclaration",
"g I": "editor::GoToImplementation",
"g y": "editor::GoToTypeDefinition",

// --- <leader>w: window nav by leader ---
"space w h": "workspace::ActivatePaneLeft",
"space w j": "workspace::ActivatePaneDown",
"space w k": "workspace::ActivatePaneUp",
"space w l": "workspace::ActivatePaneRight",

// --- <leader>g: git ---
"space g s": "git_panel::ToggleFocus",
"space g c": "git::Commit",
"space g p": "git::Push",
"space g P": "git::Pull",
"space g f": "git::Fetch",
"space g a": "git::StageAll",
"space g u": "git::UnstageAll",
"space g o": "git::OpenModifiedFiles",
"space g m": "git::GenerateCommitMessage",

// --- <leader>b: buffer additions ---
"space b p": "pane::TogglePinTab",

// --- <leader>s: search additions ---
"space s S": "project_symbols::Toggle",
"space s r": ["pane::DeploySearch", { "replace_enabled": true }],

// --- <leader>f: find additions ---
"space f r": "projects::OpenRecent",
"space f b": "tab_switcher::Toggle",

// --- <leader>x: diagnostics ---
"space x x": "diagnostics::Deploy",
```

### Step 5 — Add to the corrected `Editor && VimControl && !VimWaiting && !menu` block at line 201

```jsonc
"] ]": "vim::GoToNextReference",
"[ [": "vim::GoToPreviousReference",
"shift-h": "pane::ActivatePreviousItem",
"shift-l": "pane::ActivateNextItem"
```

### Step 6 — Standardize agent namespace (after palette verification)
If `agent::InlineAssist` exists in the command palette:
- Line 94: `assistant::InlineAssist` → `agent::InlineAssist`
- Line 95: `assistant::InlineAssist` → `agent::InlineAssist`

If it doesn't exist, leave both lines alone.

### Step 7 — Comments + structural cleanup
- Add `// Custom: shells out to a custom file_finder/grep_search task by design (see decision #1)` above the `task::Spawn` blocks.
- Update line 33 comment from `// File panel (netrw)` to `// Project panel (file tree)`.
- Update line 137 comment per decision #3.
- Add namespace banner comments inside the line-86 block (`// --- <leader>f ---`, etc.) and reorder bindings under their banners.

### Step 8 — Visual-mode indent-stay-selected (nice-to-have)
In the visual-mode block at line 192:
```jsonc
"<": ["workspace::SendKeystrokes", "< g v"],
">": ["workspace::SendKeystrokes", "> g v"]
```

---

## Out of scope (acknowledged Zed gaps)

- `<leader>q*` sessions — Zed has no session manager.
- Most `<leader>u*` UI toggles — `editor::ToggleLineNumbers`, `ToggleRelativeLineNumbers`, `ToggleAutoFormat`, `ToggleSpellCheck`, `ToggleDiagnostics` are NOT public Zed actions (Code Reviewer confirmed via doc fetch).
- `<leader>cR` rename file — no public action.
- Severity-filtered diagnostic navigation (`]e` errors-only) — Zed's `editor::GoToDiagnostic` doesn't filter.
