var mapboxTiles = L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoiY2pqY2FzdHJvIiwiYSI6ImNqN21vYXpiMDFib3UzMnQ2OG1uM205NWEifQ.8sFAUtZu22lf_o3kmEVlMg',{
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
    maxZoom: 20,
    minZoom: 3,
    noWrap: true,
    id: 'mapbox.light',
    accessToken: 'your.mapbox.access.token'
});

var bounds = L.latLngBounds([20.2222, -100.1222], [-60, -20]);

	  var cmAttr = 'Map data &copy; 2011 OpenStreetMap contributors, Imagery &copy; 2011 CloudMade',
		cmUrl = 'http://{s}.tile.cloudmade.com/BC9A493B41014CAABB98F0471D759707/{styleId}/256/{z}/{x}/{y}.png';

	  var minimal   = L.tileLayer(cmUrl, {styleId: 22677, attribution: cmAttr}),
		midnight  = L.tileLayer(cmUrl, {styleId: 999,   attribution: cmAttr});

var map = L.map('map', {maxBounds: bounds})
    .addLayer(mapboxTiles)
    .setView([-15.2222, -50.1222], 4);


map.zoomControl.setPosition('topright');

var markersAgent = new L.FeatureGroup();
var markersEvent = new L.FeatureGroup();
var markersProject = new L.FeatureGroup();
var markersSpace = new L.FeatureGroup();


var baseLayers = {
  "Light": minimal,
  "Dark": midnight
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

// Use the custom grouped layer control, not "L.control.layers"

L.control.groupedLayers(baseLayers, groupedOverlays).addTo(map);

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

}

// creating space markers

function SpaceMarkers(imageExtension, minutes){

		var getTimeNow = InitTime(minutes);

	    markersSpace.clearLayers();;

	    var redMarker = L.icon({
	    	iconUrl: "static/images/markerSpace."+imageExtension,
	    	iconSize: [25,25],
	    });

	    var promise = $.getJSON(
	      'http://mapas.cultura.gov.br/api/space/find',

	      {
	        '@select' : 'name, location, singleUrl',
	        '@or' : 1,
	        'createTimestamp' : "GT("+getTimeNow+")",
	        'updateTimestamp' : "GT("+getTimeNow+")"
	      },);

	    promise.then(function(data) {

            for(var i=0; i < data.length; i++){
            	if(data[i]["location"] != null){
	            	var marker = L.marker([data[i]["location"]["latitude"],
	            							data[i]["location"]["longitude"]],
	            							{icon: redMarker}).addTo(markersSpace);
	            	marker.bindPopup('<h6><b>Nome:</b></h6>'+data[i]["name"]+'<h6><b>Link:</b></h6><a target="_blank" href='+data[i]["singleUrl"]+'>Clique aqui</a>');
            	}
            }

            map.addLayer(markersSpace);
	    });
}

// creating Agents markers

function AgentMarkers(imageExtension, minutes){

		var getTimeNow = InitTime(minutes);

	    markersAgent.clearLayers();;

	    var blueMarker = L.icon({
	    	iconUrl: "static/images/markerAgent."+imageExtension,
	    	iconSize: [25,25],
	    });

	    var promise = $.getJSON(
	      'http://mapas.cultura.gov.br/api/agent/find',

	      {
	        '@select' : 'name, location, singleUrl ',
	        '@or' : 1,
	        'createTimestamp' : "GT("+getTimeNow+")",
	        'updateTimestamp' : "GT("+getTimeNow+")"
	      },);

	    promise.then(function(data) {

            for(var i=0; i < data.length; i++){
            	if(data[i]["location"] != null){
	            	var marker = L.marker([data[i]["location"]["latitude"],
	            							data[i]["location"]["longitude"]],
	            							{icon: blueMarker}).addTo(markersAgent);
	            	marker.bindPopup('<h6><b>Nome:</b></h6>'+data[i]["name"]+'<h6><b>Link:</b></h6><a target="_blank" href='+data[i]["singleUrl"]+'>Clique aqui</a>');
            	}
            }

            map.addLayer(markersAgent);
	    });
}

// creating events markers

function EventMarkers(imageExtension, minutes){

		var getTimeNow = InitTime(minutes);
	    markersEvent.clearLayers();

	    var yellowMarker = L.icon({
	    	iconUrl: "static/images/markerEvent."+imageExtension,
	    	iconSize: [25,25],
	    });

	    var promise = $.getJSON(
	      'http://mapas.cultura.gov.br/api/event/find',

	      {
	        '@select' : 'name, occurrences.{space.{location}}, singleUrl' ,
	        '@or' : 1,
	        'createTimestamp' : "GT("+getTimeNow+")",
	        'updateTimestamp' : "GT("+getTimeNow+")"
	      },);

	    promise.then(function(data) {

            for(var i=0; i < data.length; i++){
            	if((data[i]["occurrences"]).length != 0){
	            	var marker = L.marker([data[i]["occurrences"][0]["space"]["location"]["latitude"],
	            							data[i]["occurrences"][0]["space"]["location"]["longitude"]],
	            							{icon: yellowMarker}).addTo(markersEvent);
	            	marker.bindPopup('<h6><b>Nome:</b></h6>'+data[i]["name"]+'<h6><b>Link:</b></h6><a target="_blank" href='+data[i]["singleUrl"]+'>Clique aqui</a>');
            	}
            }

            map.addLayer(markersEvent);

	    });
}

// creating projects markers

function ProjectMarkers(imageExtension, minutes){

		var getTimeNow = InitTime(minutes);
	    markersProject.clearLayers();

	    var greenMarker = L.icon({
	    	iconUrl: "static/images/markerProject."+imageExtension,
	    	iconSize: [25,25],
	    });

	    var promise = $.getJSON(
	      'http://mapas.cultura.gov.br/api/project/find',

	      {
	        '@select' : 'name, owner.location, singleUrl ',
	        '@or' : 1,
	        'createTimestamp' : "GT("+getTimeNow+")",
	        'updateTimestamp' : "GT("+getTimeNow+")"
	      },);

	    promise.then(function(data) {


            for(var i=0; i < data.length; i++){
            	if(data[i]["owner"] != null){
	            	var marker = L.marker([data[i]["owner"]["location"]["latitude"],
	            							data[i]["owner"]["location"]["longitude"]],
	            							{icon: greenMarker}).addTo(markersProject);
	            	marker.bindPopup('<h6><b>Nome:</b></h6>'+data[i]["name"]+'<h6><b>Link:</b></h6><a target="_blank" href='+data[i]["singleUrl"]+'>Clique aqui</a>');
            	}
            }

			map.addLayer(markersProject);

	    });
}
