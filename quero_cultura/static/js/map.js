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

//
var lastDayData = new Array()
var lastHourData = new Array()
var lastMinuteData = new Array()

var instanceList = ['http://mapas.cultura.gov.br/api/',
                    'http://spcultura.prefeitura.sp.gov.br/api/',
                    'http://mapa.cultura.ce.gov.br/api/']

var typeList = ['project', 'event', 'agent', 'space']

var baseLayers = {
  "Light": mapboxTiles,
  "Dark": mapboxTilesDark
};

// Overlay layers are grouped
var groupedOverlays = {
    "": {"Agentes": markersAgent,
         "Eventos": markersEvent,
         "Espaços": markersSpace,
         "Projetos": markersProject
        }
};

L.control.groupedLayers(baseLayers, groupedOverlays).addTo(map);

/* Defines the date used by the query
   based in the last minutes passed by parameter.
   If we pass 60 as parameter this function returns
   the current date time minus 60 minutes and so on. */
function getQueryDateTime(lastMinutes){
    var currentDateTime = new Date()
    var queryDateTime = new Date()
    var timezone = 2
    queryDateTime.setHours(currentDateTime.getHours() - timezone,
                           currentDateTime.getMinutes() - lastMinutes)

	return queryDateTime.toJSON()
}

function createQueryPromise(instanceURL, markerType, lastMinutes){
    var queryDateTime = getQueryDateTime(lastMinutes);
    instanceURL = instanceURL+markerType+'/find'
    switch(markerType){
        case 'event':
            select = 'name, occurrences.{space.{location}}, singleUrl, createTimestamp, updateTimestamp'
            break
        case 'project':
            select = 'name, owner.location, singleUrl, createTimestamp, updateTimestamp'
            break
        case 'space':
        case 'agent':
            select = 'name, location, singleUrl, createTimestamp, updateTimestamp'
            break
        default:
            select = ''
    }

    var promise = $.getJSON(instanceURL, {'@select' : select,
                                          '@or' : 1,
                                          'createTimestamp' : "GT("+queryDateTime+")",
                                          'updateTimestamp' : "GT("+queryDateTime+")"
                                         });

    return promise
}

function saveAndLoadData(instanceURL, markerType, lastMinutes, saveArray, markerImageExtension) {
    var promise = createQueryPromise(instanceURL, markerType, lastMinutes)
    promise.then(function(data){
        loadMarkers(markerType, markerImageExtension, data)
        saveArray.push.apply(saveArray, data)
        if(saveArray === lastMinuteData){
            AddInfoToFeed(saveArray)
        }
        saveArray = new Array()
    })

}

function loadAndUpdateMarkers(lastMinutes, saveArray, imageExtension){
    for(i in instanceList){
        for (j in typeList){
            instanceURL = instanceList[i]
            markerType = typeList[j]
            saveAndLoadData(instanceURL, markerType, lastMinutes, saveArray, imageExtension)
        }
    }
    //checkMarkersDuplicity(lastHourData)
    map.addLayer(markersEvent)
    map.addLayer(markersProject)
    map.addLayer(markersAgent)
    map.addLayer(markersSpace)

}


function loadMarkers(markerType, imageExtension, markersData) {
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


function AddInfoToFeed(diffFeed) {

    diffFeed.forEach(function(value, key){
        var name = value.name
        var type = value.type
        var createTimestamp = value['createTimestamp']
        var updateTimestamp = value['updateTimestamp']
        var singleUrl = value['singleUrl']

        var markerLocation = {}

        if(type === 'event'){
            markerLocation = value['occurrences'].pop().space.location
        }else if(type === 'project'){
            markerLocation = value.owner.location
        }else if(type === 'agent'){
            markerLocation = value.location
        }else{
            markerLocation = value.location
        }

        if(updateTimestamp === null){
            actionDateTime = createTimestamp
            actionType = 'Criação'
        }else{
            actionDateTime = updateTimestamp
            actionType = 'Atualização'
        }
        if(markerLocation.latitude !== 0 && markerLocation.longitude !== 0){
            openstreetURL = "http://nominatim.openstreetmap.org/reverse?lat="+markerLocation.latitude+
                            "&lon="+markerLocation.longitude+"&format=json"
            promise = $.getJSON(openstreetURL)
            promise.then(function(data){
                if(data["error"] !== undefined){
                    console.log("unable to locate Geocode")
                    data.address = {"state": '', 'city': ''}
                }
                var html = AddHTMLToFeed(actionType, name, type, data.address.state,
                    data.address.city, actionDateTime, singleUrl)

                    $('#cards').append(html)
                    var height = $('#cards')[0].scrollHeight;
                    $(".block" ).scrollTop(height);
            })
        }
    },diffFeed)

}

function AddHTMLToFeed(actionType, name, type, uf, city, actionDateTime, singleUrl){
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
        "<p>"+actionType+""+ "<br>"
        +actionDateTime.date.substring(0, 19)+"<br>"
        +city+ ' - ' + uf+"</p>"+
      "</div>"+
    "</div>"
  return html
}

function GetColorByType(type) {
  var color = "red";
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
