##提取m3u的"#港澳台频道"，deepseek写的



$url = "https://github.com/suxuang/myIPTV/raw/main/ipv4.m3u"
$outputFile = "./suxuang-ipv4.m3u"

# 下载M3U文件
Invoke-WebRequest -Uri $url -OutFile $outputFile

# 读取文件内容
$filePath = $outputFile
$content = Get-Content -Path $filePath -Encoding UTF8

# 定义起始标记
$startMarker = "#港澳台频道"
$startIndex = -1

# 查找起始标记的位置
for ($i = 0; $i -lt $content.Length; $i++) {
    if ($content[$i] -eq $startMarker) {
        $startIndex = $i
        break
    }
}

# 如果找到起始标记
if ($startIndex -ne -1) {
    # 从起始标记开始，查找第一个空行
    $endIndex = $startIndex
    while ($endIndex -lt $content.Length -and $content[$endIndex] -ne "") {
        $endIndex++
    }

    # 提取从起始标记到第一个空行的内容
    $extractedContent = $content[$startIndex..($endIndex - 1)]

    # 输出提取的内容
    $extractedContent | Out-File -FilePath $outputFile -Force -Encoding utf8
} else {
    Write-Output "未找到起始标记 '$startMarker'。"
}
