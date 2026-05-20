## 1. teach-state.py: `list` subcommand

- [x] 1.1 Add `list` subparser to argument parser with `cmd_list` handler
- [x] 1.2 Implement FS scan: glob `learn-*/.teaching-state.json` from cwd
- [x] 1.3 For each valid file: read JSON, extract `topic`, `plan`, `currentModuleIndex`, `currentStep`; compute `currentModule` as `currentModuleIndex + 1`, `totalModules` as `len(plan)`, `completed` as `all(m["completed"] for m in plan)`
- [x] 1.4 Get file `mtime` via `path.stat().st_mtime`, format as `YYYY-MM-DD`
- [x] 1.5 Handle corrupted JSON: catch `json.JSONDecodeError`, emit error entry with path and description instead of crashing
- [x] 1.6 Output sorted JSON array (by `updated` descending) to stdout, exit 0 (even if empty array `[]`)
- [x] 1.7 Wire `cmd_list` into `main()` dispatch

## 2. SKILL.md: Resume flow with topic disambiguation

- [x] 2.1 Replace current recovery flow (L181-186 single-topic assumption) with 3-branch logic:
      0 topics → Phase 1 new proposal
      1 topic → direct resume (preserve current behavior)
      N topics → list options with progress, wait for user selection
      Display rules: completed → "✅ 已学完"; in-progress → "模块 X/Y 第 Z 步"; step==0 → "尚未开始"
- [x] 2.2 Add step for exact match bypass: user says "继续学 Python" → skip `list`, directly `get learn-python`

## 3. Sync to .claude/skills/

- [x] 3.1 Run `cp -r .opencode/skills/teach-anything .claude/skills/teach-anything`

## 4. Verification

- [x] 4.1 `teach-state.py list` returns `[]` when no `learn-*/` directories exist
- [x] 4.2 Create two `learn-*/.teaching-state.json` files via `init`, verify `list` returns both with correct fields
- [x] 4.3 Corrupt one file, verify `list` returns error entry for corrupted + valid entry for healthy
- [x] 4.4 Manual review: SKILL.md recovery flow reads naturally for 0/1/N branches
