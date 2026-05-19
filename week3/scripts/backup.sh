#!/bin/bash

# ── Config ──────────────────────────────────────────
BUCKET="s3://devops-backup-yourname-2026"   # ← change to your bucket name
SOURCE_DIR="$HOME/devops-lab"
BACKUP_DIR="$HOME/backups"
TIMESTAMP=$(date "+%Y-%m-%d_%H-%M-%S")
FILENAME="devops-lab-backup-$TIMESTAMP.tar.gz"
# ────────────────────────────────────────────────────

# Create local backup folder if it doesn't exist
mkdir -p "$BACKUP_DIR"

echo "📦 Creating tarball: $FILENAME"
tar -czf "$BACKUP_DIR/$FILENAME" -C "$HOME" devops-lab

if [ $? -eq 0 ]; then
    echo "✅ Tarball created: $BACKUP_DIR/$FILENAME"
else
    echo "❌ Failed to create tarball"
    exit 1
fi

echo "☁️  Uploading to S3: $BUCKET/backups/$FILENAME"
aws s3 cp "$BACKUP_DIR/$FILENAME" "$BUCKET/backups/$FILENAME"

if [ $? -eq 0 ]; then
    echo "✅ Upload successful!"
    echo "📍 Location: $BUCKET/backups/$FILENAME"
else
    echo "❌ Upload failed. Check your AWS credentials and bucket name."
    exit 1
fi
