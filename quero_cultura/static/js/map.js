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
    "": {"Agentes": markersAgent,
         "Eventos": markersEvent,
         "Espaços": markersSpace,
         "Projetos": markersProject
        }
};

L.control.groupedLayers(baseLayers, groupedOverlays).addTo(map);

// function returns hour now with minutes delay
function InitTime(minutes){

	var getTimeNow = new Date();
    getTimeNow.setHours(getTimeNow.getHours() - 3, getTimeNow.getMinutes() - minutes);
    getTimeNow.setMilliseconds(0);
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
            if(printed_key === key){
                isPrinted = true
            }
        }, printedFeed)

        if(isPrinted === false){
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
