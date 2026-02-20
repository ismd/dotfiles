---
name: music
description: Download music discographies from trackers and import into Navidrome library via beets. Use when user wants to download albums, discographies, or music.
user-invocable: true
---

# Music Download & Import

Automates: artist lookup → tracker search → torrent download → CUE split → beet import.

## Configuration

```
Download directory: $HOME/Downloads/Music
Rutracker credentials: RUTRACKER_USER, RUTRACKER_PASS (environment variables)
Music library: /mnt/qnap/Music/Music (from beets config)
Beet database: /mnt/qnap/Music/beets.db
Split script: $HOME/.bin/split-flac.sh
Tracker script: $HOME/.claude/skills/music/rutracker.py
```

## Workflow

### Step 1: Find discography

1. User invokes `/music <artist>`
2. Search MusicBrainz via Python `musicbrainzngs`:
   ```python
   import musicbrainzngs
   musicbrainzngs.set_useragent("claude-music-skill", "1.0", "noreply@example.com")
   musicbrainzngs.search_artists(artist="<name>")
   ```
3. If multiple matches — show user via AskUserQuestion to clarify
4. Get release groups:
   ```python
   musicbrainzngs.browse_release_groups(artist="<id>", release_type=["album"])
   ```
   - `Album` — studio albums (primary selection)
   - `Compilation` — compilations (secondary)
   - `EP`, `Single`, `Live` — others
5. Show albums via AskUserQuestion (multiSelect), default to studio albums only
   - Offer compilations/EPs as a separate option
6. If artist not found on MusicBrainz — notify user and ask them to provide album list manually. Import will proceed in "as-is" mode later

### Step 2: Search tracker

Strategy depends on number of selected albums:

**Many albums (3+)** — discography search:
1. Run `$HOME/.claude/skills/music/rutracker.py search "<artist> дискография flac"` (or `"<artist> discography flac"`)
2. If a discography torrent contains needed albums — use selective download (step 3)

**Few albums (1-2)** — individual album search:
1. Run `$HOME/.claude/skills/music/rutracker.py search "<artist> <album_name> flac"` for each album
2. Each album downloaded as a separate torrent

**General:**
3. If few results — try alternative queries (different language, transliteration)
4. Show results to user: title, size, seeds, format
5. User selects torrent(s) via AskUserQuestion
6. If FLAC not found — search for other lossless formats (APE, WAV, ALAC)

> **Future extension**: Other tracker sources may be added as separate scripts following the same interface (`<tracker>.py search/download`). Steps 1, 4, 5 are source-agnostic; steps 2-3 are tracker-specific.

### Step 3: Download via torrent

1. Run `$HOME/.claude/skills/music/rutracker.py download <topic_id> $HOME/Downloads/Music` — downloads .torrent file
2. Run `aria2c --show-files <torrent_file>` — list files with indices
3. Match files/directories to selected albums from step 1
4. User confirms file selection via AskUserQuestion
5. Run: `aria2c --select-file=<indices> --seed-time=0 --dir=$HOME/Downloads/Music <torrent_file>`
6. Wait for completion (aria2c shows progress)

For individual album torrents — download all files (no `--select-file`):
`aria2c --seed-time=0 --dir=$HOME/Downloads/Music <torrent_file>`

### Step 3.5: Resolve MusicBrainz release ID

For each selected torrent, attempt to identify the exact MusicBrainz release (not release group) so beet can match precisely:

1. Run `$HOME/.claude/skills/music/rutracker.py info <topic_id>` to get torrent description text
2. Analyze the description — look for:
   - Catalog number (e.g., "UICR-1139", "Номер по каталогу", "Cat #")
   - Barcode / EAN
   - Label name
   - Medium type (CD, WEB, Vinyl)
   - Country of release
3. Query MusicBrainz to find the specific release within the release group:
   ```python
   import musicbrainzngs
   musicbrainzngs.set_useragent("claude-music-skill", "1.0", "noreply@example.com")

   # If catalog number found:
   musicbrainzngs.search_releases(catno="<catno>", artist="<artist>")

   # If no catno — browse all releases in the group and filter by format/label/country:
   musicbrainzngs.browse_releases(release_group="<rg_id>", limit=100)
   ```
4. If a unique release is identified — store its ID for use in step 4
5. If still ambiguous — skip, let beet handle matching on its own

### Step 4: Process albums

For each album directory:

1. **Check format**: if single FLAC + CUE — needs splitting
   - Check CUE file encoding: `file <cue_file>`
   - If not UTF-8 (typical for Cyrillic releases): `$HOME/.bin/split-flac.sh -e <path>`
   - If UTF-8/ASCII: `$HOME/.bin/split-flac.sh <path>` (without `-e`)
   - Script creates `.split/` subdirectory with split tracks
   - Use `.split/` path for beet import
2. **Auto import**:
   - If release ID resolved in step 3.5: `beet import --search-id https://musicbrainz.org/release/<id> <path>`
   - Otherwise: `beet import <path>`
   - Do NOT use `-t` flag — let beet auto-match
   - If MusicBrainz lookup failed in step 1 — still use `beet import <path>`, beet will try its own matching
3. **Check result**: analyze beet output
   - Success → mark album as imported
   - Skipped/error → add to manual import list

### Step 5: Summary

1. List successfully imported albums
2. For problematic albums — output ready-to-run commands:
   ```
   beet import -t <path>   # run in terminal for manual selection
   ```
3. Optionally: offer to delete downloaded files after successful import

> **Future extension**: Single track import via `beet import -s <path>` for individual tracks/singles.
