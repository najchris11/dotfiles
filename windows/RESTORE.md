# Restore manifest — Backblaze-dependent files

Written 2026-08-25, while this machine still had a full Backblaze backup running. Backblaze is getting canceled soon — this is the record of what was *only* living on Backblaze at that point, so future-me knows what to look for if any of it is ever needed again.

**Status as of writing:** OneDrive and Nextcloud sync only a small fraction of this drive (Nextcloud: 28.3 GB; OneDrive: essentially empty). Everything below was local-only, with Backblaze as the sole backup copy.

## Before actually canceling Backblaze

Backblaze's web restore is fine for small stuff but painfully slow for hundreds of GB — for a restore this size, use their **restore-to-USB-drive** option (they mail a physical drive) rather than downloading a zip. Don't cancel until either:
1. a restore has actually been pulled down and verified against the SSD copy, or
2. you've deliberately decided a given item isn't worth keeping (see "safe to drop" below).

## What needs restoring, by priority

### Irreplaceable — restore no matter what
| Item | Location (was) | Size |
|---|---|---|
| Grandpa's iPod | `Desktop/Grandpa's iPod` | 88.2 GB |
| AJ's iPod | `Desktop/AJs iPod` | 5.6 GB |
| iasiah's iPod | `Desktop/iasiahs ipod` | 0.4 GB |
| 3DS/2DS/DSi backups | `Desktop/2dsbackup`, `3dsbackup`, `Mia 2ds backup 1`, `2ds backup 2`, `Documents/Naj Dsi` | ~6 GB |
| Google Takeout export (2024-07-18) | `Downloads/takeout-20240718*.tgz` (×4) | ~198 GB |
| Google Drive export batch (2023-09-27) | `Downloads/drive-download-20230927*.zip` (~25 files) | ~50 GB |
| Raw Snapchat memories export | `Documents/snap test` | 39.8 GB |
| `suzi`, `backups` (unlabeled Desktop folders) | `Desktop/suzi`, `Desktop/backups` | 5.1 GB |

### Worth keeping — music/creative production
| Item | Location (was) | Size |
|---|---|---|
| foobar2000 profile (library, playlists, DSP presets, Georgia Reborn theme) | `%APPDATA%\foobar2000-v2` | 2.0 GB |
| Serato crates/library (3 copies — consolidate to one) | `Music/_Serato_`, `Desktop/_Serato_`, `Desktop/_Serato_Backup` | ~231 MB |
| Crossfader Music Pack | `Downloads/Crossfader Music Pack.zip` | 2.4 GB |
| Adobe Creative Cloud libraries | `Documents/Adobe` | 16.2 GB (check what's cache vs. actual saved libraries first) |

### Code — should just be pushed to GitHub instead of restored from backup
16 local clones lived in `Documents/GitHub`. Most are already fully pushed. The ones that were **not** as of 2026-08-25 (fix before this stops mattering):
- `MQA_identifier` — 5 commits only on this machine, tracked remote branch is gone. **Push this somewhere or it's gone.**
- `apm-new` — 1 unpushed commit + uncommitted `angular.json` change.
- `last.fm-stuff` — uncommitted change to `current_top_albums.json`.
- `snapchat-memories-downloader` — uncommitted changes on a feature branch.
- `ipodclickwheelgamespreservationproject` — uncommitted deletions of `.gitignore`/`CHANGELOG.md`/`HASHS.md`/`LICENSE` (probably intentional, verify).

If those get pushed, this whole 12.9 GB `Documents/GitHub` folder is just re-clonable and isn't a real restore dependency.

### Safe to drop — don't bother restoring
Re-downloadable or genuinely disposable; not worth Backblaze restore time:
- Linux install ISOs — omarchy, bazzite, ubuntu 26.04, cachyos (`Downloads/*.iso`, ~23 GB)
- `CSE278_2020-010.ova` — OSU coursework VM (4.7 GB), only if no longer needed for the class
- iPod Clickwheel Games Preservation Project — stored 5+ redundant ways in Downloads (extracted folder, two `.utm` VM images, split 7z archives) totaling ~65 GB; the actual project is a pushed GitHub repo, so the Downloads copies are just build artifacts/scratch space
- Serato DJ Lite installer, misc software installers

### Small stuff, archive in full — no need to sort
Pictures (0.1 GB), Videos (4.7 GB), Music (0.8 GB) — cheap enough to just grab wholesale rather than triage.

## After the restore

Once the above has an actual copy on the SSD (or has been deliberately dropped), update this file's header to note the date Backblaze was actually canceled, and where the restored copy lives.
