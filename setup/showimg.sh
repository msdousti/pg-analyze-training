if command -v viu &> /dev/null; then
  viu "$@"
else
  open "$1"
fi
