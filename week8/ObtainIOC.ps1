
function GatherIOC {

$page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.41/IOC.html
 

#Get all the Tr elements of a HTML doc
$trs = $page.ParsedHTML.body.getElementsByTagName("tr")

#Empty arrway to hold results
$FullTable = @()
for($i = 1; $i -lt $trs.length; $i++){ #going over every tr element

    #get every td element of current tr element
    $tds = $trs[$i].getElementsByTagName("td")

    $FullTable += [pscustomobject]@{
                                    "Pattern"     = $tds[0].innerText 
                                    "Description" = $tds[1].innerText
                                  }
                                }
return $FullTable | Format-Table -AutoSize
}

$TableIOC = GatherIOC

$TableIOC 