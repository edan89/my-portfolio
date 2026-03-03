# Fix all encoding-corrupted characters in index.html
$file = "index.html"

# Read as raw bytes to preserve current state
$bytes = [System.IO.File]::ReadAllBytes($file)

# The file appears to have single-byte replacement chars (0xFFFD or similar)
# Let's read as Latin-1 to preserve all bytes, then fix
$content = [System.Text.Encoding]::GetEncoding("iso-8859-1").GetString($bytes)

# Now do targeted replacements based on context
# Each replacement targets the exact surrounding text to avoid false positives

# --- Title & Meta tags ---
$content = $content -replace 'Edgar Ortiz . Data Engineer . AI Developer', 'Edgar Ortiz — Data Engineer — AI Developer'
$content = $content -replace 'Edgar Ortiz . Portfolio showcasing', 'Edgar Ortiz — Portfolio showcasing'
$content = $content -replace 'Edgar Ortiz . Portfolio"', 'Edgar Ortiz — Portfolio"'
$content = $content -replace 'Data Engineer . AI Developer based', 'Data Engineer — AI Developer based'

# --- CSS comment ---
$content = $content -replace 'IX2 visibility rule . use CSS', 'IX2 visibility rule — use CSS'

# --- Language toggle ---
$content = $content -replace 'alt="Espa.ol"', 'alt="Español"'
$content = $content -replace '>Espa.ol<', '>Español<'

# --- Hero section ---
$content = $content -replace 'Data Engineer . Data Analyst . AI Engineer', 'Data Engineer · Data Analyst · AI Engineer'
$content = $content -replace 'Edgar Ortiz . Data Engineer &amp; AI', 'Edgar Ortiz — Data Engineer &amp; AI'

# --- Copyright ---
$content = $content -replace '>.2026<', '>©2026<'
$content = $content -replace '>. 2026 Edgar', '>© 2026 Edgar'

# --- Experience section ---
$content = $content -replace 'diagnostics in Helsinki . a career', 'diagnostics in Helsinki — a career'
$content = $content -replace '2025 . Present', '2025 – Present'
$content = $content -replace 'OAMK . Oulu', 'OAMK — Oulu'
$content = $content -replace '2020 . 2023', '2020 – 2023'
$content = $content -replace 'Project Specialist . Mobile', 'Project Specialist — Mobile'
$content = $content -replace 'Swappie OY . Helsinki', 'Swappie OY — Helsinki'
$content = $content -replace 'Promoted 3. . Production', 'Promoted 3× — Production'
$content = $content -replace '2013 . 2016', '2013 – 2016'
$content = $content -replace 'Data Analyst . Financial', 'Data Analyst — Financial'
$content = $content -replace 'Ita. Bank . Asunci.n', 'Itaú Bank — Asunción'
$content = $content -replace 'SQL . reduced delivery', 'SQL — reduced delivery'

# --- Itau Bank references ---
$content = $content -replace 'SQL at Ita. Bank,', 'SQL at Itaú Bank,'
$content = $content -replace 'at Ita. Bank\.', 'at Itaú Bank.'
$content = $content -replace 'Ita. Bank --', 'Itaú Bank --'

# --- Project badges with dots (em dashes or middots) ---
$content = $content -replace 'Featured . FastAPI . LangGraph . Supabase . Groq', 'Featured · FastAPI · LangGraph · Supabase · Groq'
$content = $content -replace 'Azure . PySpark . Supabase . Medallion', 'Azure · PySpark · Supabase · Medallion'
$content = $content -replace 'Scikit-learn . Plotly . Altair', 'Scikit-learn · Plotly · Altair'
$content = $content -replace 'React . JavaScript . HTML/CSS . WCAG . Accessibility', 'React · JavaScript · HTML/CSS · WCAG · Accessibility'
$content = $content -replace 'Docker . Airflow . Kafka . BigQuery . SQLite', 'Docker · Airflow · Kafka · BigQuery · SQLite'
$content = $content -replace '. NumPy . Streamlit . Python', '· NumPy · Streamlit · Python'
$content = $content -replace 'Streamlit . Scikit', 'Streamlit · Scikit'

# --- Project descriptions ---
$content = $content -replace 'Viz Portfolio . LIVE', 'Viz Portfolio — LIVE'
$content = $content -replace 'cloud VM . explore', 'cloud VM — explore'
$content = $content -replace 'applications . from concept', 'applications — from concept'
$content = $content -replace 'Finland . Passionate', 'Finland · Passionate'
$content = $content -replace 'Data Engineer . AI Developer<', 'Data Engineer · AI Developer<'

# --- Cert category icons (emojis corrupted to ??) ---
# Meta Front-End icon
$content = $content -replace '(<span class="cert-category-icon">)\?\?(<\/span>\s*\r?\n\s*<div class="cert-category-title" data-i18n="cert-meta-title">)', '${1}💻${2}'
# Data Engineering icon
$content = $content -replace '(<span class="cert-category-icon">)\?\?(<\/span>\s*\r?\n\s*<div class="cert-category-title" data-i18n="cert-data-title">)', '${1}📊${2}'
# Tools icon
$content = $content -replace '(<span class="cert-category-icon">)\?\?\?(<\/span>\s*\r?\n\s*<div class="cert-category-title" data-i18n="cert-tools-title">)', '${1}🛠️${2}'

# --- Experience emojis ---
$content = $content -replace '\?\? OAMK', '📍 OAMK'
$content = $content -replace '\?\? Swappie', '📍 Swappie'
$content = $content -replace '\?\? Promoted', '🚀 Promoted'
$content = $content -replace '\?\? Ita', '📍 Ita'

# --- Project badges emoji ---
$content = $content -replace '\? Featured', '⭐ Featured'
$content = $content -replace '\?\? Live', '🟢 Live'

# --- Remaining dot separators in meta/footer ---  
$content = $content -replace 'Data Engineer . Data Analyst', 'Data Engineer · Data Analyst'

# Save as UTF-8 with BOM
$utf8Bom = New-Object System.Text.UTF8Encoding($true)
[System.IO.File]::WriteAllText($file, $content, $utf8Bom)

Write-Host "All encoding issues fixed! UTF-8 BOM applied."
Write-Host "Characters restored: ñ, ú, ó, ©, —, –, ·, ×, emojis"
