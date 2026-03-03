with open('index.html', 'r', encoding='utf-8-sig') as f:
    text = f.read()

RC = '\ufffd'  # The replacement character

# Fix remaining specific patterns first (before global middot replacement)

# 1184: alt text em-dash
text = text.replace(f'Edgar Ortiz {RC} Data Engineer &amp; AI', 'Edgar Ortiz \u2014 Data Engineer &amp; AI')

# 1508: Swappie role em-dash  
text = text.replace(f'Project Specialist {RC}\r\n', 'Project Specialist \u2014\r\n')

# 1513: Coach arrows (→ corrupted to ?)
text = text.replace('? Coach ? Microsoldering', '\u2192 Coach \u2192 Microsoldering')

# 1521: Itau Bank em-dash
text = text.replace(f'Bank {RC} Asunci', 'Bank \u2014 Asunci')

# 1523: Itau desc lightning bolt
text = text.replace('? Automated reporting', '\u26A1 Automated reporting')

# 1621: LIVE badge emoji
text = text.replace('?? LIVE', '\U0001F534 LIVE')

# 1628: Data Analysis chart emoji in project title (multi-byte emoji became ??)
text = text.replace('?? Data\r\n                                                    Analysis Dashboard', '\U0001F4CA Data\r\n                                                    Analysis Dashboard')

# 1700: SQL em-dash
text = text.replace(f'SQL {RC} covering', 'SQL \u2014 covering')

# Now replace ALL remaining RC chars with middot (·) since they're all in badge strings
text = text.replace(RC, '\u00b7')

# Check remaining
remaining = text.count(RC)
print(f"Remaining replacement chars: {remaining}")

# Save as UTF-8 with BOM
with open('index.html', 'w', encoding='utf-8-sig') as f:
    f.write(text)

print("Done! All encoding issues fixed.")
