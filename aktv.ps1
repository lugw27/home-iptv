$url = "http://aktv.space/live.m3u"
$outputFile = "./aktv.m3u"

$r=Invoke-RestMethod -Method Get -Uri $url
#频道名称加上[aktv]标识
$r = $r -replace ',',',[aktv]'
#加上组名称
$r = $r -replace '#EXTINF:-1','#EXTINF:-1 group-title="aktv"'

$r | Out-File -FilePath $outputFile -Force -Encoding utf8
