$url="https://d2vldammsgprja.cloudfront.net/4e74cd22-b28e-4cdf-878e-5bb480321801/SearchIPTV.m3u"
$outputFile="./SearchIPTV.m3u"

$r=Invoke-RestMethod $url 
$r|Out-File $outputFile -Encoding utf8
