$file='iptv.m3u'
$new_file="iptv-udpate.m3u"

./suxuang-ipv4.ps1

$urls=[ordered]@{
  "suxuang-港澳台"="./suxuang-ipv4.m3u"
  "hkdvb"="./hkdvb.m3u"
}

"started"
Copy-Item -Path $file -Destination $new_file -Force
foreach ($k in $urls.keys){
  write-host $k
  $url=$urls[$k]

  if (Test-Path $url){
    $r=Get-Content -Path $url -Encoding UTF8
    $r|Add-Content -Path $new_file -Force
  }
  else{
    "文件不存在"
  }
}

"###更新时间：$((get-date).AddHours(8).ToString('yyyy_MM_dd HH:mm:ss.fff'))"|Add-Content -Path $new_file -Force

"end"
