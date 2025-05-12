#!/usr/bin/env bash

_jq_query='
  .[] | (.emoji + " :" + .aliases[0] + ": "+ .category + " » " + .description)
'

jq --raw-output "${_jq_query}" "${FZF_EMOJI_DATA_FILE}" |
  fzf \
    --delimiter " " \
    --bind 'enter:become(printf {1} | wl-copy --trim-newline)' \
    --bind 'ctrl-c:become(printf {2} | wl-copy --trim-newline)'
