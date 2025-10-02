function gatherClasses{

$page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.19/Courses.html

#Get all the tr elements of a HTML document
$trs = $page.ParsedHTML.body.getElementsByTagName("tr")

#Empty array to hold results
$FullTable = @()
for($i = 1; $i -lt $trs.length; $i++){ #going over every tr element

   # get every td element of current tr element
   $tds = $trs[$i].getElementsByTagName("td")

   # want to separate start time and end time from one time field
   $Times = $tds[5].innerText.Split("-")

   $FullTable += [pscustomobject]@{"Class Code" = $tds[0].innerText; `
                                   "Title" = $tds[1].innerText; `
                                   "Days" = $tds[4].innerText; `
                                   "Time Start" = $Times[0]; `
                                   "Instructor" = $tds[6].innerText; `
                                   "Location" = $tds[9].innerText; `
                                   }
} # end of for loop
return $FullTable
}

function daysTranslator($FullTable){

# go over every record in the table
for($i=0; $i -lt $FullTable.length; $i++){
  
  #empty array to hold days for every record
  $Days = @()

  #If you see "M" -> Monday
  if ($FullTable[$i].Days -like "*M*") {$Days += "Monday" }

  # if you see "T" followed by T,W, or F -> Tuesday
  if ($FullTable[$i].Days -like "*T[W,F]*") {$Days += "Tuesday" }

  #If you see "W" -> Wednesday 
  if ($FullTable[$i].Days -like "*W*") {$Days += "Wednesday" }

  # If you see "TH" -> Thursday
  if ($FullTable[$i].Days -like "*TH*") {$Days += "Thursday" }

  # F -> Friday
  if ($FullTable[$i].Days -like "*F*") {$Days += "Friday" }

  #Make the switch 
  $FullTable[$i].Days = $Days

} # end of for loop
Return $FullTable
}

 