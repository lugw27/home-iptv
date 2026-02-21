$url=$env:iptv_url
$outputFile="./SearchIPTV.m3u"

$r=Invoke-RestMethod $url 
$r|Out-File $outputFile -Encoding utf8
