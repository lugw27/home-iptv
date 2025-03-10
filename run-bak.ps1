$file='iptv.m3u'
$new_file="iptv-udpate.m3u"

./suxuang-ipv4.ps1

$urls=[ordered]@{
  "suxuang-港澳台"="./suxuang-ipv4.m3u"
  "hkdvb"="https://live.hkdvb.com/hls/playlist.m3u?token=560806621575418"
}

"started"
Copy-Item -Path $file -Destination $new_file -Force
foreach ($k in $urls.keys){
  write-host $k
  $url=$urls[$k]

  if (Test-Path $url){
    #本地文件
    $r=Get-Content -Path $url -Encoding UTF8
  }
  else{
    #url
    try{
      $r=Invoke-RestMethod -Method get -Uri $url -ErrorAction SilentlyContinue
      write-host "Invoke-RestMethod 成功"
      $r|Out-File "./cache/$k.cache" -force
    }
    catch{
      write-host "Invoke-RestMethod 失败"
      $r=Get-Content -Path "./cache/$k.cache" -Raw
    }

    if ($url.contains('live.hkdvb.com')){
      #修改group-title
      $r=$r -replace 'group-title=\".*\",','group-title="hkdvb",'
      #替换"Jade "
      $r=$r -replace 'Jade ',''
      #替换"[直播]"
      $r=$r -replace '\[直播\]',''
    }
  }

  $r|Add-Content -Path $new_file -Force
}

"###更新时间：$((get-date).AddHours(8).ToString('yyyy_MM_dd HH:mm:ss.fff'))"|Add-Content -Path $new_file -Force

"end"
