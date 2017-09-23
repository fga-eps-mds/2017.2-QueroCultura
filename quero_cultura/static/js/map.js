
var mymap = L.map('mapid').setView([-15.2222, -50.1222], 3.5);


L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoiY2pqY2FzdHJvIiwiYSI6ImNqN21vYXpiMDFib3UzMnQ2OG1uM205NWEifQ.8sFAUtZu22lf_o3kmEVlMg', {
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
    maxZoom: 18,
    minZoom: 3,
    id: 'mapbox.satellite',
    accessToken: 'your.mapbox.access.token'
    }).addTo(mymap);


function make_marker(latitude, longitude, typePoint) {

	var marker = L.marker([latitude, longitude]).addTo(mymap);
    marker.bindPopup(typePoint).openPopup();

}

