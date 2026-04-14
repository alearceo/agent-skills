# Using agent-skills with Cursor

## Cursor plugin (recommended for slash commands)

To use the lifecycle commands (`/spec`, `/plan`, `/build`, `/test`, `/review`, `/code-simplify`, `/ship`), install this repository as a **Cursor plugin** so Cursor reads [`.cursor-plugin/plugin.json`](../.cursor-plugin/plugin.json). Slash command definitions live in [`.claude/commands/`](../.claude/commands/) (that is the `commands` path in the manifest).

```bash
git clone https://github.com/alearceo/agent-skills.git
cd agent-skills
mkdir -p ~/.cursor/plugins/local
ln -s "$(pwd)" ~/.cursor/plugins/local/agent-skills
```

Alternatively, copy the clone into `~/.cursor/plugins/local/agent-skills` instead of symlinking. Restart Cursor if the plugin does not appear immediately.

The same layout works if you open this repo from another path: the plugin root must contain `.cursor-plugin/plugin.json` and the rest of the repo (`skills/`, `agents/`, `hooks/`, etc.).

## Setup (skills without the plugin)

### Option 1: Rules Directory

Cursor supports a `.cursor/rules/` directory for project-specific rules:

```bash
# Create the rules directory
mkdir -p .cursor/rules

# Copy skills you want as rules
cp /path/to/agent-skills/skills/test-driven-development/SKILL.md .cursor/rules/test-driven-development.md
cp /path/to/agent-skills/skills/code-review-and-quality/SKILL.md .cursor/rules/code-review-and-quality.md
cp /path/to/agent-skills/skills/incremental-implementation/SKILL.md .cursor/rules/incremental-implementation.md
```

Rules in this directory are automatically loaded into Cursor's context.

### Option 2: .cursorrules File

Create a `.cursorrules` file in your project root with the essential skills inlined:

```bash
# Generate a combined rules file
cat /path/to/agent-skills/skills/test-driven-development/SKILL.md > .cursorrules
echo "\n---\n" >> .cursorrules
cat /path/to/agent-skills/skills/code-review-and-quality/SKILL.md >> .cursorrules
```

### Option 3: Notepads

Cursor's Notepads feature lets you store reusable context. Create a notepad for each skill you use frequently:

1. Open Cursor → Settings → Notepads
2. Create a new notepad named "swe: Test-Driven Development"
3. Paste the content of `skills/test-driven-development/SKILL.md`
4. Reference it in chat with `@notepad swe: Test-Driven Development`

## Recommended Configuration

### Essential Skills (Always Load)

Add these to `.cursor/rules/`:

1. `test-driven-development.md` — TDD workflow and Prove-It pattern
2. `code-review-and-quality.md` — Five-axis review
3. `incremental-implementation.md` — Build in small verifiable slices

### Phase-Specific Skills (Load as Notepads)

Create notepads for skills you use contextually:

- "swe: Spec Development" → `spec-driven-development/SKILL.md`
- "swe: Frontend UI" → `frontend-ui-engineering/SKILL.md`
- "swe: Security" → `security-and-hardening/SKILL.md`
- "swe: Performance" → `performance-optimization/SKILL.md`

Reference them with `@notepad` when working on relevant tasks.

## Usage Tips

1. **Don't load all skills at once** — Cursor has context limits. Load 2-3 skills as rules and keep others as notepads.
2. **Reference skills explicitly** — Tell Cursor "Follow the test-driven-development rules for this change" to ensure it reads the loaded rules.
3. **Use agents for review** — Copy `agents/code-reviewer.md` content and tell Cursor to "review this diff using this code review framework."
4. **Load references on demand** — When working on performance, reference `@notepad performance-checklist` or paste the checklist content.
