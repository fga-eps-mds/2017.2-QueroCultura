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

function createMarkerIcon(color, extension){
    filename = ''
    switch (color) {
        case 'red': filename = 'markerSpace'
            break
        case 'blue': filename = 'markerAgent'
            break
        case 'yellow': filename = 'markerEvent'
            break
        case 'green': filename = 'markerProject'
            break
    }

    return L.icon({ iconUrl: "static/images/"+filename+"."+ extension,
                    iconSize: [25,25],
                 });
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

}

function createPromise(url, type, minutes){
    var getTimeNow = InitTime(minutes);

    select = ''
    switch(type){
        case 'event': select = 'name, occurrences.{space.{location}}, singleUrl'
            break
        case 'project': select = 'name, owner.location, singleUrl '
            break
        case 'space':
        case 'agent':
            select = 'name, location, singleUrl'
            break
    }

    var promise = $.getJSON(url,
      {
        '@select' : select,
        '@or' : 1,
        'createTimestamp' : "GT("+getTimeNow+")",
        'updateTimestamp' : "GT("+getTimeNow+")"
      },);
      return promise
}

function loadMarkers(type, imageExtension, minutes){
    loadMarkersInInstance(type,'http://mapas.cultura.gov.br/api/'+type+'/find' ,imageExtension,minutes)
    loadMarkersInInstance(type,'http://spcultura.prefeitura.sp.gov.br/api/'+type+'/find' ,imageExtension,minutes)
    loadMarkersInInstance(type,'http://mapa.cultura.ce.gov.br/api/'+type+'/find' ,imageExtension,minutes)
}

function loadMarkersInInstance(type, url, imageExtension, minutes) {
    var promise = createPromise(url, type, minutes)

    promise.then(function(data) {
        switch (type) {
            case 'project': createProjectMarker(data, imageExtension)
            break
            case 'event': createEventMarker(data, imageExtension)
            break
            case 'agent': createAgentMarker(data, imageExtension)
            break
            case 'space': createSpaceMarker(data, imageExtension)
            break
        }
    });
}

function createSpaceMarker(data, imageExtension){
    var redMarker = createMarkerIcon('red', imageExtension)

    for(var i=0; i < data.length; i++){
        if(data[i]["location"] != null){
            var marker = L.marker([data[i]["location"]["latitude"],
                                    data[i]["location"]["longitude"]],
                                    {icon: redMarker}).addTo(markersSpace);
            marker.bindPopup('<h6><b>Nome:</b></h6>'+data[i]["name"]+'<h6><b>Link:</b></h6><a target="_blank" href='+data[i]["singleUrl"]+'>Clique aqui</a>');
        }
    }
}

// creating space markers
function SpaceMarkers(imageExtension, minutes){
    markersSpace.clearLayers()

    loadMarkers('space', imageExtension, minutes)

    map.addLayer(markersSpace)
}

// creating Agents markers
function createAgentMarker(data, imageExtension){
    var blueMarker = createMarkerIcon('blue', imageExtension)

    for(var i=0; i < data.length; i++){
    	if(data[i]["location"] != null){
        	var marker = L.marker([data[i]["location"]["latitude"],
        							data[i]["location"]["longitude"]],
        							{icon: blueMarker}).addTo(markersAgent);
        	marker.bindPopup('<h6><b>Nome:</b></h6>'+data[i]["name"]+'<h6><b>Link:</b></h6><a target="_blank" href='+data[i]["singleUrl"]+'>Clique aqui</a>');
    	}
    }
}

function AgentMarkers(imageExtension, minutes){
    markersAgent.clearLayers()

    loadMarkers('agent', imageExtension, minutes)

    map.addLayer(markersAgent)
}

// creating events markers
function createEventMarker(data, imageExtension){
    var yellowMarker = createMarkerIcon('yellow', imageExtension)

    for(var i=0; i < data.length; i++){
    	if((data[i]["occurrences"]).length != 0){
        	var marker = L.marker([data[i]["occurrences"][0]["space"]["location"]["latitude"],
        							data[i]["occurrences"][0]["space"]["location"]["longitude"]],
        							{icon: yellowMarker}).addTo(markersEvent);
        	marker.bindPopup('<h6><b>Nome:</b></h6>'+data[i]["name"]+'<h6><b>Link:</b></h6><a target="_blank" href='+data[i]["singleUrl"]+'>Clique aqui</a>');
    	}
    }
}

function EventMarkers(imageExtension, minutes){
    markersEvent.clearLayers()

    loadMarkers('event', imageExtension, minutes)

    map.addLayer(markersEvent)
}

// creating projects markers
function createProjectMarker(data, imageExtension){
    var greenMarker = createMarkerIcon('green', imageExtension)

    for(var i=0; i < data.length; i++){
    	if(data[i]["owner"] != null){
        	var marker = L.marker([data[i]["owner"]["location"]["latitude"],
        							data[i]["owner"]["location"]["longitude"]],
        							{icon: greenMarker}).addTo(markersProject);
        	marker.bindPopup('<h6><b>Nome:</b></h6>'+data[i]["name"]+'<h6><b>Link:</b></h6><a target="_blank" href='+data[i]["singleUrl"]+'>Clique aqui</a>');
    	}
    }

}

function ProjectMarkers(imageExtension, minutes){
    markersProject.clearLayers()

    loadMarkers('project', imageExtension, minutes)

    map.addLayer(markersProject);
}
