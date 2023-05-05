if command -v sx &> /dev/null && [ "1" = "$(fgconsole 2>/dev/null)" ]; then
    exec sx &> /dev/null
fi
