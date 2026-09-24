#!/usr/bin/env bash
# PreToolUse (Edit|Write|MultiEdit): bloquea escrituras sobre archivos de secretos.
# Exit 2 = bloquear; el mensaje de stderr se devuelve a Claude.
input="$(cat)"
path="$(printf '%s' "$input" | grep -oE '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | head -n1 | sed -E 's/.*:[[:space:]]*"(.*)"/\1/')"
[ -z "$path" ] && exit 0
name="$(basename "$path")"

case "$name" in
  .env.example|.env.sample|.env.template) exit 0 ;;
  .env|.env.*|*.pem|*.key|*.p12|*.pfx|id_rsa*|id_ed25519*|credentials*.json|*secret*.json)
    echo "Bloqueado: '$path' parece contener secretos. Edítalo manualmente o usa .env.example." >&2
    exit 2 ;;
esac
exit 0
