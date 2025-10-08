
<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>


<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}

# Create a function called checkPassword in String-Helper that:
#              - Checks if the given string is at least 6 characters
#              - Checks if the given string contains at least 1 special character, 1 number, and 1 letter
#              - If the given string does not satisfy conditions, returns false
#              - If the given string satisfy the conditions, returns true

function checkPassword($password){

    $hasLength = $password.Length -ge 6

    $hasLetters = $password -match '[a-zA-Z]'

    $hasNumbers =  $password-match '[0-9]'

    $hasSpecials = $password -match '[^a-zA-Z0-9]'

    if($hasLength -and $hasLetters -and $hasNumbers -and $hasSpecials){
        return $true 
    }
    else{
        return $false
    }

}