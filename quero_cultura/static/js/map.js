
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


var bounds = L.latLngBounds([40, -170.1222], [-70, 60]);

var map = L.map('map', {maxBounds: bounds})
	.addLayer(mapboxTiles)
	.setView([-15.2222, -50.1222], 4);


map.zoomControl.setPosition('topright');

var markersAgent = new L.FeatureGroup();
var markersEvent = new L.FeatureGroup();
var markersProject = new L.FeatureGroup();
var markersSpace = new L.FeatureGroup();

//

var typeList = ['project', 'event', 'agent', 'space']

var lastDayData = initialize_data_map()
var lastHourData = initialize_data_map()
var lastMinuteData = initialize_data_map()

function initialize_data_map(){
    var map = {}
    for (var i =0; i < typeList.length; i++){
        map[typeList[i]] = new Array()
    }
    return map
}

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


function loadAndUpdateMarkers(data, imageExtension){
    data.forEach(function(value){
        loadMarkers(value.marker_type, imageExtension, value)
    })

    map.addLayer(markersEvent)
    map.addLayer(markersProject)
    map.addLayer(markersAgent)
    map.addLayer(markersSpace)

}


function loadMarkers(markerType, imageExtension, markerData) {
    switch (markerType) {
        case 'project': createProjectMarker(markerData, imageExtension)
        break
        case 'event': createEventMarker(markerData, imageExtension)
        break
        case 'agent': createAgentMarker(markerData, imageExtension)
        break
        case 'space': createSpaceMarker(markerData, imageExtension)
        break
    }
}


function updateFeed(recent_markers) {
    recent_markers.forEach(function(value){

        if(value.city === undefined){
            value.city = ''
        }
        if(value.state === undefined){
            value.state = ''
        }
        var html = AddHTMLToFeed(value)
        create_feed_block(html)
    },recent_markers)
}

function create_feed_block(html){
    $('#cards').append(html)
    var height = $('#cards')[0].scrollHeight;
    $(".block" ).scrollTop(height);
}

function AddHTMLToFeed(marker){
    imageType = GetImageByType(marker.marker_type)
    latitude = marker.location.latitude
    longitude = marker.location.longitude
    var html = "<div id='content'>"+
                   "<div id='point'>"+
                       "<a href='javascript:void(0);' onclick='javascript:focusOnMarker("+ latitude +","+ longitude +");'>"+
                       "<img src='"+imageType+"' height='35px' width='30px'  style=' padding-top: 3px'></a>"+
                   "</div> "+

                   "<div id='text'>  "+
                       "<a href='"+marker.instance_url+"' target='_blank'>"+formatName(marker.name)+"</a>"+
                       "<p>"+marker.action_type+" - "
                            +formatTime(marker.action_time)+"<br>"
                            +formatLocation(marker.city, marker.state)+
                       "</p>"+
                   "</div>"+
               "</div>"
    return html
}

function formatName(name){
    if(name === ''){
        return '--------'
    }else{
        return name
    }
}

function formatLocation(city, state){
    result = ''
    if(state !== ''){
        result = state
    }
    if(city !== ''){
        result = city + " - " + result
    }
    return result
}
function formatTime(timeString){
    return timeString.substring(11, 19)
}

function GetImageByType(type) {

    console.log(type)
    var image
    switch (type) {
        case 'project':
            image = "static/images/markerProject.png"
            break

        case 'space':
            image = "static/images/markerSpace.png"
            break

        case 'agent':
            image = "static/images/markerAgent.png"
            break

        case 'event':
            image = "static/images/markerEvent.png"
            break


    }

    return image
}

// This method is used to receive new markers
// from django without reload the page
function new_markers() {
    $.ajax({
      method: "POST",
      url: "/new_markers",
      headers: {'X-CSRFToken': generated_csrf_token},
      data: {},
      success: function(data) {
        console.log(data)
        loadAndUpdateMarkers(data['markers'], 'gif')
        updateFeed(data['markers'])
      },
      error: function(error){
          console.log(error)
      }
    })
  }


function focusOnMarker(latitude, longitude){
    map.fitBounds([
        [latitude, longitude],
        [latitude, longitude]
    ]);
    map.setZoom(12);
}
