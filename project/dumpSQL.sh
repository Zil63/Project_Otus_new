#!/usr/bin/env bash
set -euo pipefail
STAMP="$(date +%F_%H-%M-%S)"
OUTDIR="$(dirname "$0")/backups"
mkdir -p "$OUTDIR"
docker exec mysql_master sh -lc 'mysqldump -uroot -p"$MYSQL_ROOT_PASSWORD" --all-databases' | gzip > "$OUTDIR/db_${STAMP}.sql.gz"
echo "Backup written to $OUTDIR/db_${STAMP}.sql.gz"
