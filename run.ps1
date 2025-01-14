$file='iptv.m3u'
$new_file="iptv-udpate.m3u"

$hkdvb_token=$env:hkdvb_token
$urls="https://live.hkdvb.com/hls/playlist.m3u?token=$hkdvb_token",'https://www.mytvsuper.com.mp/m3u/Live.m3u'

"started"
Copy-Item -Path $file -Destination $new_file -Force
foreach ($url in $urls){
  $r=Invoke-RestMethod -Method get -Uri $url
  $r|Add-Content -Path $new_file -Force
}

pwd
ls

"end"
