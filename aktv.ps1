$url = "http://aktv.space/live.m3u"
$outputFile = "./aktv.m3u"

$r=Invoke-RestMethod -Method Get -Uri $url
$r -replace '#EXTINF:-1','#EXTINF:-1 group-title="aktv"'

$r | Out-File -FilePath $outputFile -Force -Encoding utf8
