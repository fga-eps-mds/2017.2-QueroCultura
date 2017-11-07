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
            select = 'name, occurrences.{space.{location}}, singleUrl, subsite, createTimestamp, updateTimestamp'
            break
        case 'project':
            select = 'name, owner.location, singleUrl, subsite, createTimestamp, updateTimestamp'
            break
        case 'space':
        case 'agent':
            select = 'name, location, singleUrl, subsite, createTimestamp, updateTimestamp'
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

        saveArray[markerType].push.apply(saveArray[markerType], data)

        if(saveArray === lastMinuteData){
            AddInfoToFeed(saveArray[markerType])
            saveArray[markerType] = new Array()
        }

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

function get_marker_location(value){
    console.log(value)

    switch (value.type) {
        case "evento":
            var occurrences = value['occurrences'].pop()
            if(occurrences === undefined){
                return {latitude:0, longitude:0}
            }else{
                return occurrences.space.location
            }
        case "projeto":
            return value.owner.location
        default:
            return value.location
    }
}

function create_url_to_feed(value){
    return new Promise((resolve, reject) =>{
        if(value["subsite"] === null){
            resolve(value['singleUrl'])
        }else{
            var splitUrl = value["singleUrl"].split("/")
            instanceUrl = splitUrl[0]+"//"+splitUrl[2]

            var promise = requestSubsite(instanceUrl+'/api/subsite/find', value.subsite)
            promise.then(function(subsiteData) {
                var url = "http://"+subsiteData[0]["url"] + "/"+type+"/" + value["id"]
                console.log(url)
                resolve(url)
            });
        }
    })
}

function get_action(createTimestamp, updateTimestamp){
    var update = {}
    if(updateTimestamp === null){
        update.time = createTimestamp
        update.name = 'Criação'
    }else{
        update.time = updateTimestamp
        update.name = 'Atualização'
    }
    return update
}

function create_location_promise(markerLocation){
    openstreetURL = "http://nominatim.openstreetmap.org/reverse?lat="+markerLocation.latitude+"&lon="+markerLocation.longitude+"&format=json"
    return $.getJSON(openstreetURL)
}

function get_location_data(markerLocation){
    return new Promise((resolved, reject)=>{
        if(markerLocation.latitude !== 0 && markerLocation.longitude !== 0){
            promise = create_location_promise(markerLocation)
            promise.then(function(data){
                if(data["error"] !== undefined){
                    console.log("unable to locate Geocode")
                    data.address = {"state": '', 'city': ''}
                }

                if(data.address.city == undefined){
                    data.address.city = data.address.town
                }
                if(data.address.city == undefined){
                    data.address.city = ''
                }
                if(data.address.state == undefined){
                    data.address.state = ''
                }
                console.log(data.address.city)
                resolved(data)
            })
        }else{
            reject({})
        }
    })
}
function AddInfoToFeed(diffFeed) {

    diffFeed.forEach(async function(value, key){
        var markerLocation = get_marker_location(value)
        var url = await create_url_to_feed(value)
        var data = await get_location_data(markerLocation)
        var action = get_action(value.createTimestamp, value.updateTimestamp)

        var html = AddHTMLToFeed(action, value.name, value.type, data.address, url)
        create_feed_block(html)
    },diffFeed)

}

function create_feed_block(html){
    $('#cards').append(html)
    var height = $('#cards')[0].scrollHeight;
    $(".block" ).scrollTop(height);
}

function AddHTMLToFeed(action, name, type, address, url){
    color = GetColorByType(type)
    var html = "<div id='content'>"+
                   "<div id='point'>"+
                       "<svg>"+
                           "<circle cx='15' cy='25' r='7' fill='"+color+"' />"+
                       "</svg>"+
                   "</div> "+

                   "<div id='text'>  "+
                       "<a href='"+url+"' target='_blank'>"+name+"</a>"+
                       "<p>"+action.name+""+ "<br>"
                            +action.time.date.substring(0, 19)+"<br>"
                            +address.city+ ' - ' + address.state+
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
