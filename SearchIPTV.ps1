$templateFile = "./SearchIPTV.template"
$outputFile = "./SearchIPTV.m3u"

$content = Get-Content $templateFile -Encoding utf8

$result=@()
foreach ($line in $content)
{
    $head=$line.Split('!!')[0]
    $keyword = $head.Split(",")[-1]
    $excludeWords=$line.Split("!!").Split("|")
    $body = @{
        "seerch" = $keyword
        "Submit" = "+"
        "name"="NjU1Nzkz"
        "city"   = "a17060b392.7589241763811"
    }
    $r = Invoke-RestMethod -Uri "https://tonkiang.us/" `
        -Method Post `
        -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:147.0) Gecko/20100101 Firefox/147.0" `
        -ContentType "application/x-www-form-urlencoded" `
        -Body $body

    $html = ConvertFrom-HTML -Content (Optimize-HTML -Content $r) -Engine AngleSharp
    $selector = $html.QuerySelectorAll('html body div div div.resultplus')

    $result+=$head
    foreach ($i in $selector)
    {
        try
        {
            $link = $i.ChildNodes[1].ChildNodes[1].innerhtml
            $name = $i.ChildNodes[0].ChildNodes[0].ChildNodes[0].innerhtml
        }
        catch
        {
            continue
        }
        
        if ($name -notin $excludeWords){
            $result+=$link
        }
    }
}

$result|select -Unique|Out-File $outputFile -Encoding utf8

