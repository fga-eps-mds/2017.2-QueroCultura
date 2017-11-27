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
var instanceList = ['http://mapas.cultura.gov.br/api/',
                    'http://spcultura.prefeitura.sp.gov.br/api/',
                    'http://mapa.cultura.ce.gov.br/api/']


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


function create_url_to_feed(value){
    return new Promise((resolve, reject) =>{
        console.log(value)
        if(value['subsite'] === "null" || value['subsite'] === null){
            resolve(value['single_url'])
        }else{
            var splitUrl = value["single_url"].split("/")
            instanceUrl = splitUrl[0]+"//"+splitUrl[2]

            var promise = requestSubsite(instanceUrl+'/api/subsite/find', value['subsite'])
            promise.then(function(subsiteData) {
                var url = "http://"+subsiteData[0]["url"] + "/"+type+"/" + value["platform_id"]
                console.log(url)
                resolve(url)
            });
        }
    })
}


function updateFeed(recent_markers) {
    recent_markers.forEach(async function(value){

        var url = await create_url_to_feed(value)
        if(value.city == undefined){
            value.city = ''
        }
        if(value.state == undefined){
            value.state = ''
        }
        var html = AddHTMLToFeed(value, url)
        create_feed_block(html)
    },recent_markers)

}

function create_feed_block(html){
    $('#cards').append(html)
    var height = $('#cards')[0].scrollHeight;
    $(".block" ).scrollTop(height);
}

function AddHTMLToFeed(marker, url){
    color = GetColorByType(type)
    var html = "<div id='content'>"+
                   "<div id='point'>"+
                       "<svg>"+
                           "<circle cx='15' cy='25' r='7' fill='"+color+"' />"+
                       "</svg>"+
                   "</div> "+

                   "<div id='text'>  "+
                       "<a href='"+url+"' target='_blank'>"+marker.name+"</a>"+
                       "<p>"+marker.action_type+""+ "<br>"
                            +marker.action_time.substring(0, 19)+"<br>"
                            +marker.city+ ' - ' + marker.state+
                       "</p>"+
                   "</div>"+
               "</div>"
    return html
}

function GetColorByType(type) {
  var color = "red";
  switch (type) {
    case 'projeto':
      color = "#28a745"
      break

    case 'espaco':
      color = "#dc3545"
      break

    case 'agente':
      color = "#17a2b8"
      break

    case 'evento':
      color = "#ffc107"
      break

    default:
      color = "black"
  }

  return color
}
