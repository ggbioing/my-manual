#!/usr/bin/env bash
git remote set-url origin $(git remote get-url origin | tr '/' '\' | sed 's/nas13/fileserver\\RD$/gI')
