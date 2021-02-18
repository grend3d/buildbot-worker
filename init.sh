#!/bin/sh

if [-z "$1" -o -z "$2"]; then
	echo "Usage: $0 [master host] [worker name] [worker password (optional)]"
	exit;
fi

MASTER_HOST="$1"
WORKER_NAME="$2"
WORKER_PASS="passvvord"

if [-n "$3"]; then
	WORKER_PASS="$3"
fi

python3 -m venv sandbox

. sandbox/bin/activate
pip install --upgrade pip
pip install -r requirements.txt

buildbot-worker create-worker worker "$MASTER_HOST" "$WORKER_NAME" "$WORKER_PASS"
buildbot-worker start worker
