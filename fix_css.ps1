$cssPath = "assets/css/main.css"
$content = [System.IO.File]::ReadAllText($cssPath)
$old = '    .home-header_labels-wrap {\r\n        bottom: 0.25rem;\r\n    }'
$new = "    .home-header_labels-wrap {`r`n        bottom: 0.25rem;`r`n    }"
$content = $content.Replace($old, $new)
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($cssPath, $content, $utf8NoBom)
Write-Host "CSS line 6400 fixed"
