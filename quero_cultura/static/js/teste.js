var mapboxTiles = L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoiY2pqY2FzdHJvIiwiYSI6ImNqN21vYXpiMDFib3UzMnQ2OG1uM205NWEifQ.8sFAUtZu22lf_o3kmEVlMg',{
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
    maxZoom: 18,
    minZoom: 3,
    id: 'mapbox.satellite',
    accessToken: 'your.mapbox.access.token'
});

var map = L.map('map')
    .addLayer(mapboxTiles)
    .setView([-15.2222, -50.1222], 3.5);

var markers = new L.FeatureGroup();

function getSpace(){

	var getTimeNow = new Date();
	    getTimeNow.setHours(getTimeNow.getHours() - 3, getTimeNow.getMinutes()-1);
	    getTimeNow = getTimeNow.toJSON();

	    console.log(getTimeNow);
	    apaga();

	    var promise = $.getJSON(
	      'http://mapas.cultura.gov.br/api/agent/find',

	      {
	        '@select' : 'id, name, location',
	        '@or' : 1,
	        'createTimestamp' : "GT("+getTimeNow+")",
	        'updateTimestamp' : "GT("+getTimeNow+")"
	      },);

	    promise.then(function(data) {

            console.log(data);
            for(var i=0; i < data.length; i++){
            	var marker = L.marker([data[i]["location"]["latitude"], data[i]["location"]["longitude"]]).addTo(markers);

            }
            printPoints();

	    });
}

function printPoints(){
	map.addLayer(markers);
}

function apaga(){
	markers.clearLayers();
}
