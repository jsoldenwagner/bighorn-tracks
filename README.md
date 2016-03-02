# bighorn-tracks
##A guide to updating the animated bighorn map:

This is a guide to updating the bighorn map.  The map is created by a script (written in javascript) that lives here:
  
http://github.com/nationalparkservice/projects/tree/gh-pages/yose/sierra-nevada-bighorn-sheep
  
![](screenshots/mapScripts.jpg)
  
The initial map is linked to app.js. Additional maps are linked to map2.js, map3.js, and map4.js. 
These maps can be embedded in nps.gov pages by referencing their assigned ID's. NPMap ID's are assigned by Nate Irwin and more can be requested by contacting Nate via email at nate_irwin@nps.gov or npmap@nps.gov.
  
###To Edit An Existing Map: 

Click on the {your map name goes here}.js file that you want to edit, map2.js in this tutorial, and then select 
the pen icon to make edits:

![](screenshots/editJavascript.jpg)

Edits can be made to the GPS track, the map's `center` and `zoom`, and the text above the time-slider control. 
Let's look at each of these in turn.

###The GPS Track
The bighorn map generates the GPS track from GeoJSON data that can be found in the `data` variable and looks like so:
```javascript
var data = {
  "type": "Feature",
  "geometry": {
    "type": "MultiPoint",
    "coordinates": [/*array of [long,lat] coordinates*/]
  },
  "properties": {
    "time": [/*array of UNIX timestamps*/]
  }
};
```
To update the track, simply paste new arrays of [long,lat] coordinates and UNIX timestamps into the appropriate [].
For clarity:
```javascript
var data = {
  "type": "Feature",
  "geometry": {
    "type": "MultiPoint",
    "coordinates": [[long1,lat1], [long2,lat2],[long3,lat3],...,[longN,latN]]
  },
  "properties": {
    "time": [timestamp1, timestamp2, timestamp3,...,timestampN]
  }
};
```
Note that the size of these two arrays must be the same.  These arrays can be generated by the ui.R script found in this repository.
More on this later in the tutorial.
###Setting the Map's Center and Zoom
The `center` and `zoom` can be found in the `NPMap` variable:
```javascript
var NPMap = {
  div: 'map',
  center: {
    lat: 37.744275,
    lng: -119.330004
  },
  [...]
  zoom: 13,
  maxZoom: 15
};
```
When you update the GPS track you will most likely need to reset the `center` and `zoom`.  Coordinates for the `center` can be obtained by using [Google Maps](https://www.google.com/maps) right-click `What's here?` feature. Simply mouse over a point that would make a good `center`, right-click and select `What's here?`, then click on the coordinates to copy and paste the `lat` and `lng`. 
The `zoom` level can range from 1 to 15, with greater numbers indicating a greater zoom (`zoom: 1` being completely zoomed out).
###Setting the Text for the Time-Slider Control
The text for the time-slider can be found in the `hooks` property of the `NPMap` variable:
```javascript
var NPMap = {
  div: 'map',
  [...]
  hooks: {
    init: function (callback) {
      [...]
      $(document).ready(function () {
        $('div.leaflet-bottom.leaflet-left').prepend('<p><b>EWE S375: 5/17/2015 to 7/5/2015</b></p>');
      });
      callback();
    }
  },
  [...]
  zoom: 13,
  maxZoom: 15
};
```
In this example the text above the time-slider is set by the HTML: `<p><b>EWE S375: 5/17/2015 to 7/5/2015</b></p>`.
Set the text for the animal and date range that corresponds to your GPS track.
###Creating a New Map
To create a new map click on the `New file` button:

![](screenshots/newFile.jpg)

Give the new {your map name goes here}.js file a fantastic name (ending in .js), then copy and paste the _entire_ code of an existing map or `template.js`:

![](screenshots/newFilePaste.jpg)

Set the GPS track, `center`, `zoom`, and time-slider control text as described in this tutorial and commit the 
new file:

![](screenshots/commitNewFile.jpg)

Send an email to nate_irwin@nps.gov or npmap@nps.gov with the name of the new file and request a new NPMap ID.
When you receive the ID, which will look something like `0301fc5d-d3db-4103-be9e-f296f2774a35`, paste it into the comments section at the top of your new file:

![](screenshots/comments.jpg)

Congratulations! Your map is now live and can be viewed at `nps.gov/maps/full.html?mapId={paste your ID here}`.
Your NPMap ID can be used by NPS web managers to embed your map in nps.gov pages.

###Acquiring and Updating the Raw Data:
The raw data comes from Dave German of the California Department of Fish and Wildlife (CDFW):
```
David German
Research Analyst
California Department of Fish and Wildlife
787 North Main Street, Suite 220
Bishop, CA 93514
(760) 873 8536 (o)
(760) 937 6203 (c)
David.German@wildlife.ca.gov
```
Request new data from Dave via email.  Be sure to give him the most recent date in the current data set.  The data will arrive as an 
attached `.csv` or `.txt` file and should look something like:
```
"S365","F","20150327","00:00:00","291937","4176270","Ca","37.7100725149946","-119.360377411937"
"S366","F","20150327","00:00:00","292137","4176059","Ca","37.7082177034732","-119.358050025941"
"S367","F","20150327","00:00:00","292145","4176075","Ca","37.708363609175","-119.357963910376"
"S370","F","20150327","00:00:00","291699","4176374","Ca","37.7109550328541","-119.363105062366"
"S373","F","20150327","00:00:14","292077.3","4176115","Ca","37.7087084815902","-119.358742602366"
"S372","F","20150327","00:00:24","291643.6","4176348","Ca","37.7107082889349","-119.36372569515"
"S368","F","20150327","00:00:40","292157","4176131","Ca","37.7088706499004","-119.357843871892"
"S371","F","20150327","00:01:34","291893.4","4176214","Ca","37.7095582978477","-119.360855569136"
"S367","F","20150327","04:00:00","292156","4176075","Ca","37.7083661041025","-119.357839220353"
[...]
```
Use this new data to extend the current data set by appending it to the `gpsData.csv` file found in the `data` directory of this repository (Excel is useful for this purpose):

![](screenshots/gpsData.jpg)

###Processing the Raw Data with the ui.R Script:
The GeoJSON arrays of [long,lat] coordinates and UNIX timestamps needed to update a GPS track are generated by the ui.R script in this repository. Download the zipped repository to a computer that has [RStudio](https://www.rstudio.com/home/) installed:

![](screenshots/ZIP.jpg)

The ui.R script requires the following R packages: `shiny`, `sp`, and `dplyr`. Install these packages from the RStudio command line:
```R
install.packages(c("shiny", "sp", "dplyr"))
```
Once these packages are installed simply go to the directory with the downloaded files and open `ui.R`. RStudio will open:

![](screenshots/ui_R.jpg)



