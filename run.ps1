$file='iptv.m3u'
$new_file="iptv-udpate.m3u"

$urls=[ordered]@{
    "hkdvb"="https://live.hkdvb.com/hls/playlist.m3u?token=560806621546352"
    #"judy"="https://www.mytvsuper.com.mp/m3u/Live.m3u"
}

"started"
Copy-Item -Path $file -Destination $new_file -Force
foreach ($k in $urls.keys){
  $url=$urls[$k]

  try{
    $r=Invoke-RestMethod -Method get -Uri $url -ErrorAction SilentlyContinue
    $r|Out-File "/cache/$k.cache"
  }
  catch{
    $r=Get-Content -Path "/cache/$k.cache" -Raw
  }

  if ($url.contains('live.hkdvb.com')){
    #修改group-title
    $r=$r -replace 'group-title=\".*\",','group-title="hkdvb",'
    #替换"Jade "
    $r=$r -replace 'Jade ',''
    #替换"[直播]"
    $r=$r -replace '\[直播\]',''
  }
  $r|Add-Content -Path $new_file -Force
}

"###更新时间：$((get-date).AddHours(8).ToString('yyyy_MM_dd HH:mm:ss.fff'))"|Add-Content -Path $new_file -Force
pwd
ls

"end"
