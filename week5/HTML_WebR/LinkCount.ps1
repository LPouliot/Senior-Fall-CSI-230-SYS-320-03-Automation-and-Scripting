$scraped_page = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.31/ToBeScrapped.html

# Get a count of the links in the page
$scraped_page.Links

# Display links as HTML Element
$scraped_page.ParsedHtml

# Display only URl and its text
$scraped_page.Links | Select-Object href, outerText

$h2s = $scraped_page.ParsedHtml.body.getElementsByTagName("h2") | Select-Object outerText
$h2s

# Print innerText of every div element that has the class as "div-1"
$divs1 = $scraped_page.ParsedHtml.body.getElementsByTagName("div") | where { `
$_.getAttributeNode("class").value -ilike "div-1" } | Select innerText

$divs1

