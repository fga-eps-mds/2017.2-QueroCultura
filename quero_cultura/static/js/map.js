var mapboxTiles = L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoiY2pqY2FzdHJvIiwiYSI6ImNqN21vYXpiMDFib3UzMnQ2OG1uM205NWEifQ.8sFAUtZu22lf_o3kmEVlMg',{
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
    maxZoom: 20,
    minZoom: 3,
    id: 'mapbox.dark',
    accessToken: 'your.mapbox.access.token'
});

var map = L.map('map')
    .addLayer(mapboxTiles)
    .setView([-15.2222, -50.1222], 4);

map.zoomControl.setPosition('topright');

var markersAgent = new L.FeatureGroup();
var markersEvent = new L.FeatureGroup();
var markersProject = new L.FeatureGroup();
var markersSpace = new L.FeatureGroup();

function getPoints(){
	getSpace();
	getEvent();
	getAgent();
	getProject();
}

function getSpace(){	

	var getTimeNow = new Date();
	    getTimeNow.setHours(getTimeNow.getHours() - 100, getTimeNow.getMinutes()-1);
	    getTimeNow = getTimeNow.toJSON();

	    markersSpace.clearLayers();;

	    var greenMarker = L.icon({
	    	iconUrl: "static/images/markerSpace.gif",
	    	iconSize: [20,20],
	    });

	    var promise = $.getJSON(
	      'http://mapas.cultura.gov.br/api/space/find',

	      {
	        '@select' : 'id, name, location',
	        '@or' : 1,
	        'createTimestamp' : "GT("+getTimeNow+")",
	        'updateTimestamp' : "GT("+getTimeNow+")"
	      },);

	    promise.then(function(data) {

            for(var i=0; i < data.length; i++){
            	if((data[i]["location"]).length != 0){
	            	var marker = L.marker([data[i]["location"]["latitude"], 
	            							data[i]["location"]["longitude"]], 
	            							{icon: greenMarker}).addTo(markersEvent);
            	}
	        	
            }

            map.addLayer(markersSpace);
	    });
}

function getAgent(){	

	var getTimeNow = new Date();
	    getTimeNow.setHours(getTimeNow.getHours() - 100, getTimeNow.getMinutes()-1);
	    getTimeNow = getTimeNow.toJSON();

	    markersAgent.clearLayers();;

	    var greenMarker = L.icon({
	    	iconUrl: "static/images/markerAgent.gif",
	    	iconSize: [20,20],
	    });

	    var promise = $.getJSON(
	      'http://mapas.cultura.gov.br/api/agent/find',

	      {
	        '@select' : 'id, name, location',
	        '@or' : 1,
	        'createTimestamp' : "GT("+getTimeNow+")",
	        'updateTimestamp' : "GT("+getTimeNow+")"
	      },);

	    promise.then(function(data) {

            for(var i=0; i < data.length; i++){
            	if((data[i]["location"]).length != 0){
	            	var marker = L.marker([data[i]["location"]["latitude"], 
	            							data[i]["location"]["longitude"]], 
	            							{icon: greenMarker}).addTo(markersAgent);
            	}
	        	
            }

            map.addLayer(markersAgent);
	    });
}

function getEvent(){	

	var getTimeNow = new Date();
	    getTimeNow.setHours(getTimeNow.getHours() - 100, getTimeNow.getMinutes()-1);
	    getTimeNow = getTimeNow.toJSON();

	    markersEvent.clearLayers();
		
	    var greenMarker = L.icon({
	    	iconUrl: "static/images/markerEvent.gif",
	    	iconSize: [20,20],
	    });

	    var promise = $.getJSON(
	      'http://mapas.cultura.gov.br/api/event/find',

	      {
	        '@select' : 'id, name, occurrences.{space.{location}}',
	        '@or' : 1,
	        'createTimestamp' : "GT("+getTimeNow+")",
	        'updateTimestamp' : "GT("+getTimeNow+")"
	      },);

	    promise.then(function(data) {

            for(var i=0; i < data.length; i++){
            	if((data[i]["occurrences"]).length != 0){
	            	var marker = L.marker([data[i]["occurrences"][0]["space"]["location"]["latitude"], 
	            							data[i]["occurrences"][0]["space"]["location"]["longitude"]], 
	            							{icon: greenMarker}).addTo(markersEvent);
            	}
	        	
            }
            
            map.addLayer(markersEvent);

	    });
}

function getProject(){	

	var getTimeNow = new Date();
	    getTimeNow.setHours(getTimeNow.getHours() - 100, getTimeNow.getMinutes()-1);
	    getTimeNow = getTimeNow.toJSON();

	    markersProject.clearLayers();
		
	    var greenMarker = L.icon({
	    	iconUrl: "static/images/markerAgent.gif",
	    	iconSize: [20,20],
	    });

	    var promise = $.getJSON(
	      'http://mapas.cultura.gov.br/api/project/find',

	      {
	        '@select' : 'id, name, occurrences.{space.{location}}',
	        '@or' : 1,
	        'createTimestamp' : "GT("+getTimeNow+")",
	        'updateTimestamp' : "GT("+getTimeNow+")"
	      },);

	    promise.then(function(data) {

            console.log(data);
/*
            for(var i=0; i < data.length; i++){
            	if((data[i]["occurrences"]).length != 0){
	            	var marker = L.marker([data[i]["occurrences"][0]["space"]["location"]["latitude"], 
	            							data[i]["occurrences"][0]["space"]["location"]["longitude"]], 
	            							{icon: greenMarker}).addTo(markersProject);
            	}
	        		
            }
            
            
*/
			map.addLayer(markersProject);
          
	    });

}