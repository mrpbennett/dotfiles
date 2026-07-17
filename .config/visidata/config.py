# ~/.config/visidata/config.py
# LazyVim-mirrored keybindings for VisiData (XDG config, v2.9+)
#
# Rules:
#   - bindkey(key, longname) only uses REAL longnames (verified from VisiData source)
#   - addCommand(key, longname, execstr) uses Python execstr for anything custom
#   - vd.editCellBindings for insert-mode remaps
#   - Sheet for table ops; specific subclasses when overriding their defaults
#
# Discover longnames live: press a key and read the status bar, or z Ctrl+H

# ── Navigation ─────────────────────────────────────────────────────────────────
# hjkl, gg/G, Ctrl-f/Ctrl-b, zz, and {/} already match Vim by default.
Sheet.unbindkey('H')
Sheet.bindkey('H', 'go-screen-top')
Sheet.unbindkey('L')
Sheet.bindkey('L', 'go-screen-bottom')
Sheet.bindkey('Ctrl+D', 'go-pagedown-half')
Sheet.bindkey('Ctrl+U', 'go-pageup-half')
Sheet.bindkey('0', 'go-leftmost')
Sheet.unbindkey('$')
Sheet.bindkey('$', 'go-rightmost')

# ── Editing ────────────────────────────────────────────────────────────────────
# i → edit cell  (LazyVim: i = insert; VD default is 'e')
# unbind 'i' first — it defaults to addcol-incr on TableSheet
Sheet.unbindkey('i')
Sheet.bindkey('i', 'edit-cell')

# a → edit cell then move right  (LazyVim: a = insert after)
Sheet.addCommand('a', 'edit-cell-then-right',
    'cursorCol.setValues([cursorRow], editCell(cursorVisibleColIndex)); cursorRight(1)')

# o → add a tracked row below and edit its first cell
Sheet.addCommand('o', 'add-row-below',
    'r=cursorRowIndex; t=addRows([newRow()], index=r); vd.sync(t); sheet.cursorRowIndex=min(r+1, len(rows)-1); sheet.cursorVisibleColIndex=0; vd.draw_all(); sheet.execCommand("edit-cell")')

# O → add a tracked row above and edit its first cell
Sheet.addCommand('O', 'add-row-above',
    'r=cursorRowIndex; t=addRows([newRow()], index=r-1); vd.sync(t); sheet.cursorRowIndex=min(r, len(rows)-1); sheet.cursorVisibleColIndex=0; vd.draw_all(); sheet.execCommand("edit-cell")')

# d already deletes the current row; x clears the current cell.
Sheet.unbindkey('x')
Sheet.bindkey('x', 'delete-cell')

# u → undo
Sheet.unbindkey('u')
Sheet.bindkey('u', 'undo-last')

# Ctrl-r → redo
BaseSheet.unbindkey('Ctrl+R')
BaseSheet.bindkey('Ctrl+R', 'redo-last')

# ── Selection (visual mode analog) ────────────────────────────────────────────
# v → toggle-select current row and advance
Sheet.unbindkey('v')
Sheet.bindkey('v', 'stoggle-row')

# V → select current row and advance
Sheet.bindkey('V', 'select-row')

# ── Search ─────────────────────────────────────────────────────────────────────
# /  search-next      (already default — forward regex search in column)
# ?  search-prev      (already default — backward regex search)
# n  search-next      (already default)
# N  search-prev      (already default)
# No changes needed; identical to LazyVim.

# ── Sheet / buffer navigation ──────────────────────────────────────────────────
# Ctrl-o → jump to previous sheet  (LazyVim: Ctrl-o = jump list back)
for (key, sheettype), _ in list(vd.bindkeys.iterall()):
    if key == 'Ctrl+O':
        vd.unbindkey(key, sheettype)
BaseSheet.bindkey('Ctrl+O', 'jump-prev')

# q → quit current sheet  (already default — same as :q)
# Q → quit sheet without saving  (already default)
# gq → quit all  (already default — same as :qa)

# ── Save ────────────────────────────────────────────────────────────────────────
# :w writes the root sheet to its existing source; use Space for addcol-split.
Sheet.unbindkey(':')
vd.allPrefixes.append(':')
BaseSheet.bindkey(':w', 'save-source')

# ── Insert-mode (cell editing) keybindings ─────────────────────────────────────
# These fire while a cell is being edited.
# acceptThenFunc(longname) saves the edit then executes the named command.

# Enter → accept, move down, and continue editing
vd.editCellBindings['Enter'] = acceptThenFunc('go-down', 'edit-cell')

# Esc → accept and return to normal mode; Ctrl+C still cancels
vd.editCellBindings['Esc'] = acceptThenFunc()

# ── Options ────────────────────────────────────────────────────────────────────
options.quitguard = True   # prompt before quitting with unsaved changes
options.motd_url  = ''     # disable network message-of-the-day on startup
