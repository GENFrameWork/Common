#!/usr/bin/env bash
#
# sync_from_windows.sh
#
# One-way synchronization script:
#   Windows source folder (/mnt/c/...)  ?  Linux ext4 mirror (~/dev/src_mirror/...).
#
# The mirror is NOT intended for editing. It is used only for fast compilation.
# All changes must come from the Windows side.
#
# Main features:
#   - Performs a safe one-direction sync (Windows ? WSL).
#   - Uses rsync with recommended options for NTFS?ext4.
#   - Supports --dry-run mode.
#   - Writes a marker file to prevent reversed sync accidents.
#   - Uses an exclude list if available.
#   - Stores last sync timestamp.
#

set -euo pipefail

########################################
# Parse arguments
########################################

DRY_RUN=0
if [[ "${1:-}" == "--dry-run" ]]; then
    DRY_RUN=1
    shift
fi

if [[ $# -ne 2 ]]; then
    echo "Usage: $0 [--dry-run] <SRC_WIN_in_/mnt/...> <DST_MIRROR_in_ext4>" >&2
    exit 2
fi

SRC_WIN="$1"
DST_MIRROR="$2"

########################################
# Validations
########################################

# Check source exists
if [[ ! -d "$SRC_WIN" ]]; then
    echo "ERROR: Source directory does not exist: $SRC_WIN" >&2
    exit 1
fi

# Ensure source is under /mnt/* (Windows side)
if [[ "$SRC_WIN" != /mnt/* ]]; then
    echo "ERROR: Source path must reside under /mnt/... (Windows filesystem). Received: $SRC_WIN" >&2
    exit 1
fi

# Ensure destination exists
mkdir -p "$DST_MIRROR"

########################################
# Marker file to prevent direction reversal
########################################

MARKER_FILE="$DST_MIRROR/.mirror_from_windows"

if [[ -f "$MARKER_FILE" ]]; then
    RECORDED_SRC="$(cat "$MARKER_FILE" || true)"
    if [[ "$RECORDED_SRC" != "$SRC_WIN" ]]; then
        echo "ERROR: Mirror already initialized from a different source: $RECORDED_SRC" >&2
        echo "Aborting to prevent reversed synchronization." >&2
        exit 1
    fi
else
    echo "$SRC_WIN" > "$MARKER_FILE"
fi

########################################
# Exclude file
########################################

EXCLUDE_FILE="mirror_excludes.txt"

if [[ ! -f "$EXCLUDE_FILE" ]]; then
    echo "WARNING: Exclude file not found: $EXCLUDE_FILE (continuing without excludes)." >&2
fi

########################################
# Build rsync flags
########################################

RSYNC_FLAGS=(
    -a                                  # archive mode (recursive, preserves times, etc.)
    --delete                            # mirror behavior: remove files not present in source
    --delete-excluded                   # also delete excluded files already present in mirror
    --modify-window=1                   # adjust for timestamp granularity differences NTFS?ext4
    --no-perms                          # avoid permission noise from NTFS attributes
    --chmod=Du=rwx,Dgo=rx,Fu=rw,Fgo=r   # normalize permissions in mirror
    --info=stats2,progress2             # useful statistics and progress info
    --itemize-changes
)

# Dry-run mode
if [[ $DRY_RUN -eq 1 ]]; then
    RSYNC_FLAGS+=(--dry-run)
fi

# Exclude list
if [[ -f "$EXCLUDE_FILE" ]]; then
    RSYNC_FLAGS+=(--exclude-from="$EXCLUDE_FILE")
fi

########################################
# Perform the synchronization
########################################

#rsync -av --progress --itemize-changes "$SRC_WIN"/ "$DST_MIRROR"/   "${RSYNC_FLAGS[@]}" "$SRC_WIN"/ "$DST_MIRROR"/

#rsync -av --progress --itemize-changes --exclude-from="$EXCLUDE_FILE" "$SRC_WIN"/ "$DST_MIRROR"/ | grep '^>f' | awk '{print $2}'
#SYNC_TRANSFERRED=-1

SYNC_TRANSFERRED=$(rsync "${RSYNC_FLAGS[@]}" "$SRC_WIN"/ "$DST_MIRROR"/ | grep "Number of regular files transferred" | awk '{print $6}')
export SYNC_TRANSFERRED=$SYNC_TRANSFERRED


########################################
# Store last sync timestamp
########################################

date -u +"%Y-%m-%dT%H:%M:%SZ" > "$DST_MIRROR/.last_sync_utc"

