var mapboxTiles = L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoiY2pqY2FzdHJvIiwiYSI6ImNqN21vYXpiMDFib3UzMnQ2OG1uM205NWEifQ.8sFAUtZu22lf_o3kmEVlMg',{
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
    maxZoom: 20,
    minZoom: 3,
    noWrap: true,
    id: 'mapbox.light',
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

// function returns hour now with minutes delay
function InitTime(minutes){

	var getTimeNow = new Date();
    getTimeNow.setHours(getTimeNow.getHours() - 3, getTimeNow.getMinutes() - minutes);
    getTimeNow = getTimeNow.toJSON();
	return getTimeNow;
}

function MarkersPoints(){

    SpaceMarkers("png", 1440); //1440 = 24 x 60, minutes in a day
	EventMarkers("png", 1440);
	AgentMarkers("png", 1440);
	ProjectMarkers("png", 1440);

	SpaceMarkers("gif", 60);
	EventMarkers("gif", 60);
	AgentMarkers("gif", 60);
	ProjectMarkers("gif", 60);

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
