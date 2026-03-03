$content = [System.IO.File]::ReadAllText("index.html")
$utf8 = New-Object System.Text.UTF8Encoding($true)
[System.IO.File]::WriteAllText("index.html", $content, $utf8)
Write-Host "Encoding fixed to UTF-8 with BOM"
