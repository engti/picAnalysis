# Social Pic Analysis

Take pictures and passes them through [MS Cognitive API](https://www.microsoft.com/cognitive-services/en-us/) to get data about the facial characteristics.

## Key components
* main.R
* dataProc.R
* pic_functions.R

### main
There's a csv file which contains the Brand Names, their FB page links, and the page ID [this is the key data, you can find it by viewing the source of the FB page and searching for *pageID*]. You can manually add the brands your interested in here.
It then goes to the brand pages and fetches the last *n* posts and its posts and likes data. 

### dataProc
It takes the data from above and gives you an *n* sample from each brand

### pic_functions
Takes the *n* sample from above and downloads the profile pic for each user. It sources a file named *ms_api_access.R* which merely sets the [API access key](https://www.microsoft.com/cognitive-services/en-us/apis).

It then takes each downloaded profile picture and then passes them to the MS Cognitive API and returns smile, and facial hair data.

