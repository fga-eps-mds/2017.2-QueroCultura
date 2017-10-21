var mapboxTiles = L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoiY2pqY2FzdHJvIiwiYSI6ImNqN21vYXpiMDFib3UzMnQ2OG1uM205NWEifQ.8sFAUtZu22lf_o3kmEVlMg',{
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
    maxZoom: 20,
    minZoom: 3,
    noWrap: true,
    id: 'mapbox.light',
    accessToken: 'your.mapbox.access.token'
});
var mapboxTilesDark = L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoiY2pqY2FzdHJvIiwiYSI6ImNqN21vYXpiMDFib3UzMnQ2OG1uM205NWEifQ.8sFAUtZu22lf_o3kmEVlMg',{
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
    maxZoom: 20,
    minZoom: 3,
    noWrap: true,
    id: 'mapbox.dark',
    accessToken: 'your.mapbox.access.token'
});

var bounds = L.latLngBounds([20.2222, -100.1222], [-60, -20]);

var map = L.map('map', {maxBounds: bounds})
	.addLayer(mapboxTiles)
	.setView([-15.2222, -50.1222], 4);


map.zoomControl.setPosition('topright');

var markersAgent = new L.FeatureGroup();
var markersEvent = new L.FeatureGroup();
var markersProject = new L.FeatureGroup();
var markersSpace = new L.FeatureGroup();


var baseLayers = {
  "Light": mapboxTiles,
  "Dark": mapboxTilesDark
};

// Overlay layers are grouped
var groupedOverlays = {
"": {
  "Agentes": markersAgent,
  "Eventos": markersEvent,
  "Espaços": markersSpace,
  "Projetos": markersProject,
  },
};

L.control.groupedLayers(baseLayers, groupedOverlays).addTo(map);

/* Defines the date used by the query
   based in the last minutes passed by parameter.
   If we pass 60 as parameter this function returns
   the current date time minus 60 minutes and so on. */
   function getQueryDateTime(lastMinutes){
    var currentDateTime = new Date()
    var queryDateTime = new Date()
    var timezone = 3
    queryDateTime.setHours(currentDateTime.getHours() - timezone,
                           currentDateTime.getMinutes() - lastMinutes)

	return queryDateTime.toJSON()
}

function createQueryPromise(instanceURL, markerType, lastMinutes){
    var queryDateTime = getQueryDateTime(lastMinutes);
    instanceURL = instanceURL+markerType+'/find'
    console.log(instanceURL)

    switch(markerType){
        case 'event':
            select = 'name, occurrences.{space.{location}}, singleUrl'
            break
        case 'project':
            select = 'name, owner.location, singleUrl '
            break
        case 'space':
        case 'agent':
            select = 'name, location, singleUrl'
            break
        default:
            select = ''
    }

    var promise = $.getJSON(instanceURL,
      {
        '@select' : select,
        '@or' : 1,
        'createTimestamp' : "GT("+queryDateTime+")",
        'updateTimestamp' : "GT("+queryDateTime+")"
      },);

      return promise
}

function saveQueryResult(instanceURL, markerType, lastMinutes, queryName) {
    
    var promise = createQueryPromise(instanceURL, markerType, lastMinutes)
    var storageKey = queryName + '-' + markerType

    promise.then(function(data){
        localStorage.setItem(storageKey, JSON.stringify(data))
        loadMarkers(markerType, 'png', data)
    })

}

/* Function to load the markers of the last 24 hours in the first time
that the user access the page or refresh it */
function firstMarkersLoad(instanceURL){
    var lastDay = 1440 // A day has 1440 minutes
    var typeList = ['project', 'event', 'agent', 'space']

    for (i in typeList){
        markerType = typeList[i]
        saveQueryResult(instanceURL, markerType, lastDay, 'last-day')
        saveQueryResult(instanceURL, markerType, lastMinute, 'last-minute')
    }

    map.addLayer(markersEvent)
    map.addLayer(markersProject)
    map.addLayer(markersAgent)
    map.addLayer(markersSpace)
}

function loadMarkers(markerType, imageExtension, markersData) {
    console.log(markerType)
    markersData = checkDoubleMarkers(markerType)
    console.log(markersData)

    switch (markerType) {
        case 'project': createProjectMarker(markersData, imageExtension)
        break
        case 'event': createEventMarker(markersData, imageExtension)
        break
        case 'agent': createAgentMarker(markersData, imageExtension)
        break
        case 'space': createSpaceMarker(markersData, imageExtension)
        break
    }
}

function lastMinuteMarker(instanceURL) {
  var lastMinute = 1
  var typeList = ['project', 'event', 'agent', 'space']

  for (i in typeList){
      markerType = typeList[i]
      saveQueryResult(instanceURL, markerType, lastMinute, 'last-minute')
  }

  map.addLayer(markersEvent)
  map.addLayer(markersProject)
  map.addLayer(markersAgent)
  map.addLayer(markersSpace)
}

function checkDoubleMarkers(markerType) {
  var lastMinuteMarkers = JSON.parse(localStorage.getItem('last-minute' + '-' + markerType))
  var lastDayMarkers = JSON.parse(localStorage.getItem('last-day' + '-' + markerType))
  var validMarkers = lastDayMarkers
  var aux = Array()

  for (var i = 0; i < validMarkers.length; i++) {
    validMarkers[i]['img-ext'] = 'png'
    for (var j = 0; j < lastMinuteMarkers.length; j++) {
      if(Object.is(validMarkers[i].id, lastMinuteMarkers[j].id)){
        validMarkers[i] = lastMinuteMarkers[j]
        validMarkers[i]['img-ext'] = 'gif'
      }else{
        console.log("aaa")
        lastMinuteMarkers[j]['img-ext'] = 'gif'
        aux.push(lastMinuteMarkers[j])
      }
    }
  }
  validMarkers.push.apply(validMarkers, aux)
  return validMarkers
}

// function returns hour now with minutes delay
function InitTime(minutes){

	var getTimeNow = new Date();
    getTimeNow.setHours(getTimeNow.getHours() - 3, getTimeNow.getMinutes() - minutes);
    getTimeNow = getTimeNow.toJSON();
	return getTimeNow;
}

function MarkersPoints(firstTime){

	if(map.hasLayer(markersAgent) || firstTime){
		AgentMarkers("png", 1440); //1440 = 24 x 60, minutes in a day
		AgentMarkers("gif", 60);
	}

	if(map.hasLayer(markersEvent) || firstTime){
		EventMarkers("png", 1440);
		EventMarkers("gif", 60);
	}

	if(map.hasLayer(markersSpace) || firstTime){
		SpaceMarkers("png", 1440);
		SpaceMarkers("gif", 60);
	}

  if(map.hasLayer(markersProject) || firstTime){
		ProjectMarkers("png", 1440);
		ProjectMarkers("gif", 60);
	}

    updateFeed()
}

function updateFeed(){
    var isPrinted = false
    newMarkers.forEach(function(value, key){
        isPrinted = false

        printedFeed.forEach(function(printed_value,printed_key){
            if(printed_key == key){
                isPrinted = true
            }
        }, printedFeed)

        if(isPrinted == false){
            diffFeed.set(key,value)
            printedFeed.set(key,value)
        }
    }, newMarkers)

    //######## Inserir no Feed os objetos contidos no Difffeed aqui antes de limpa-lo
    AddInfoToFeed(diffFeed)
    console.log(diffFeed)
    diffFeed = new Map()
}

function SpaceMarkers(imageExtension, minutes){
    markersSpace.clearLayers()

    loadMarkers('space', imageExtension, minutes)

    map.addLayer(markersSpace)
}

function AgentMarkers(imageExtension, minutes){
    markersAgent.clearLayers()

    loadMarkers('agent', imageExtension, minutes)

    map.addLayer(markersAgent)
}

function EventMarkers(imageExtension, minutes){
    markersEvent.clearLayers()

    loadMarkers('event', imageExtension, minutes)

    map.addLayer(markersEvent)
}

function ProjectMarkers(imageExtension, minutes){
    markersProject.clearLayers()

    loadMarkers('project', imageExtension, minutes)

    map.addLayer(markersProject);
}

function AddInfoToFeed(diffFeed) {
  var count = 0

  diffFeed.forEach(function(value,key){
    var name = value['name']
    var type = value['type']
    var singleUrl = value['singleUrl']

    if(count < 10){
      var html = AddHTMLToFeed(name, type, singleUrl)

      $('#cards').append(html)
      var height = $('#cards')[0].scrollHeight;
      console.log("h", height);
      $(".block" ).scrollTop(height);
    }
    count++

  }, diffFeed)
}

function AddHTMLToFeed(name, type, singleUrl){
  color = GetColorByType(type)

  var html =
    "<div id='content'>"+
      "<div id='point'> "+
      "  <svg> "+
          "<circle cx='15' cy='25' r='7' fill='"+color+"' />  "+
        "</svg> "+
      "</div> "+

      "<div id='text'>  "+
        "<a href='"+singleUrl+"'>"+name+"</a>"+
      "</div>"+
    "</div>"
  return html
}

function GetColorByType(type) {
  var color = "red";
  console.log(type);
  switch (type) {
    case 'project':
      color = "#28a745"
      break

    case 'space':
      color = "#dc3545"
      break

    case 'agent':
      color = "#17a2b8"
      break

    case 'event':
      color = "#ffc107"
      break

    default:
      color = "black"
  }

  return color
}
