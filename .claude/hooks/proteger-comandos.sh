#!/usr/bin/env bash
# PreToolUse (Bash): bloquea comandos destructivos o que reescriben historia compartida.
# Exit 2 = bloquear; el mensaje de stderr se devuelve a Claude.
input="$(cat)"
cmd="$(printf '%s' "$input" | grep -oE '"command"[[:space:]]*:[[:space:]]*"([^"\\]|\\.)*"' | head -n1 | sed -E 's/^"command"[[:space:]]*:[[:space:]]*"//; s/"$//')"
[ -z "$cmd" ] && exit 0

block() { echo "Bloqueado por política del proyecto: $1. Si es realmente necesario, pídele al usuario que lo ejecute." >&2; exit 2; }

printf '%s' "$cmd" | grep -qE 'git[[:space:]]+push[^;&|]*(--force([^-]|$)|[[:space:]]-f([[:space:]]|$))' && block "git push --force (usa --force-with-lease en ramas propias)"
printf '%s' "$cmd" | grep -qE 'git[[:space:]]+push[^;&|]*[[:space:]](origin[[:space:]]+)?(main|master)([[:space:]]|$)' && block "push directo a main/master (usa una rama y PR)"
printf '%s' "$cmd" | grep -qE 'git[[:space:]]+reset[[:space:]]+--hard' && block "git reset --hard (descarta trabajo sin confirmación)"
printf '%s' "$cmd" | grep -qE 'rm[[:space:]]+-[a-zA-Z]*r[a-zA-Z]*f?[[:space:]]+(/|~|\$HOME|\*)([[:space:]]|$)' && block "rm -rf sobre raíz, home o comodín"
printf '%s' "$cmd" | grep -qiE '(drop[[:space:]]+(database|schema)|truncate[[:space:]]+table)' && block "operación destructiva de base de datos"
exit 0
