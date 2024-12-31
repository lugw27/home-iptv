$file='iptv.m3u'
$new_file="iptv-udpate.m3u"
$url='https://www.mytvsuper.com.mp/m3u/Live.m3u'

"started"
$r=Invoke-RestMethod -Method get -Uri $url

Copy-Item -Path $file -Destination $new_file -Force
$r|Add-Content -Path $new_file -Force

Get-Content -Path $new_file

"end"
