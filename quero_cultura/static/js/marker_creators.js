var newMarkers = new Map()
var printedFeed = new Map()
var diffFeed = new Map()

// Contains markers printed on map
var printedMarkers = Array()

/* Add an marker icon to the map
   considering the icon extension
*/
function createMarkerIcon(markerType, extension){
    filename = ''
    switch (markerType) {
        case 'space': filename = 'markerSpace'
            break
        case 'agent': filename = 'markerAgent'
            break
        case 'event': filename = 'markerEvent'
            break
        case 'project': filename = 'markerProject'
            break
    }
    if(extension == "gif"){
      var imageLocation = "static/images/"+filename+"."+"gif"
      return L.icon({ iconUrl: imageLocation,
        iconSize: [25,25],
      });
    }else{
      var imageLocation = "static/images/"+filename+"."+"png"
      return L.icon({ iconUrl: imageLocation,
        iconSize: [25,25],
      });
    }
}

/* Return a string with the subsite's url, using an subsiteId
*/
function getSubsite(subsiteId){
    subsite = subsites[subsiteId].toString()
    return subsite
}

/* Return instance initials
*/
function getInitialInstance(data){
  var url = data["singleUrl"]
  var splitUrl = url.split(".")
  return splitUrl[2]
}

/*  Create an ID to identify the marker when added to the map
*/
function makeIdForMarker(data){
  var initialsInstance = getInitialInstance(data)
  var id = data["id"]
  var idString = id.toString()
  var identification = initialsInstance+idString
  return identification
}

/*
*/
function setZIndex(imageExtension){
  if(imageExtension == "gif"){
    return 1000
  }else{
    return -30
  }
}

/* Create a popup to marker
*/
function createPopup(type,data,marker){

    // Check if exist an subsite link, if exist, change url to subsite.
    if(data.subsite == null){
        //In normal flux, doesn't exist subsite and we use "singleUrl"
        var popup = '<h6><b>Nome:</b></h6>'+data.name+
                    '<h6><b>Link:</b></h6><a target="_blank" href='+data.singleUrl+'>Clique aqui</a>'
        marker.bindPopup(popup);
    }else{
        // remove a marker type to url
        var splitUrl = data.singleUrl.split("/")
        instanceUrl = splitUrl[0]+"//"+splitUrl[2]

        // this responpose get a subsite link for a instanceUrl
        // remember that mapas br and ceara instances have subsites
        response = $.getJSON(instanceUrl+'/api/subsite/find',
        {
            '@select' : 'url',
            'id': 'eq('+data.subsite+')'
        }).then(function(subsiteData) {
            linkSubsite = "http://"+subsiteData[0]["url"] + "/"+type+"/" + data.id
            var popup = '<h6><b>Nome:</b></h6>'+data.name+
                        '<h6><b>Link:</b></h6><a target="_blank" href='+linkSubsite+'>Clique aqui</a>'
            marker.bindPopup(popup);
            console.log(linkSubsite)
        });
    }
}

function addMarkerToMap(data, icon, imageExtension, type, featureGroup, latitude, longitude){
    var valueZindex = setZIndex(imageExtension)
    var idForMarker = makeIdForMarker(data)
    newMarkers.set(idForMarker, data)

    // Instantiates a Marker object given a geographical point and optionally an options object
    var marker = L.marker([latitude, longitude], {icon: icon}).setZIndexOffset(valueZindex).addTo(featureGroup);

    createPopup(type,data,marker)
    var identifiedMarker = {"id" : data.id,"marker" : marker}
    printedMarkers.push(identifiedMarker)
}

/* Create a space marker and add into map
   receiving an 'data' that constains space informations obtained of api
*/
function createSpaceMarker(data, imageExtension){
    var icon = createMarkerIcon('space', imageExtension)
    var type = "espaco"

    for(var i=0; i < data.length; i++){
        if(data[i]["location"]){
            var latitude = data[i]["location"]["latitude"]
            var longitude = data[i]["location"]["longitude"]
            addMarkerToMap(data[i], icon, imageExtension, type, markersSpace, latitude, longitude)
        }
    }
}

/* Create a agent marker and add into map
   receiving an 'data' that constains agent informations obtained of api
*/
function createAgentMarker(data, imageExtension){
    var icon = createMarkerIcon('agent', imageExtension)
    var type = "agente"

    for(var i=0; i < data.length; i++){
        if(data[i]["location"]){
            var latitude = data[i]["location"]["latitude"]
            var longitude = data[i]["location"]["longitude"]
            addMarkerToMap(data[i], icon, imageExtension, type, markersAgent, latitude, longitude)
        }
    }
}

/* Create a event marker and add into map
   receiving an 'data' that constains event informations obtained of api
*/
function createEventMarker(data, imageExtension){
    var icon = createMarkerIcon('event', imageExtension)
    var type = "evento"

    for(var i=0; i < data.length; i++){
    	  if((data[i]["occurrences"]).length){
            var latitude = data[i]["occurrences"][0]["space"]["location"]["latitude"]
            var longitude = data[i]["occurrences"][0]["space"]["location"]["longitude"]
            addMarkerToMap(data[i], icon, imageExtension, type, markersEvent, latitude, longitude)
    	  }
    }
}

/* Create a project marker and add into map
   receiving an 'data' that constains project informations obtained of api
*/
function createProjectMarker(data, imageExtension){
    var icon = createMarkerIcon('project', imageExtension)
    var type = "projeto"

    for(var i=0; i < data.length; i++){
    	  if(data[i]["owner"]){
            var latitude = data[i]["owner"]["location"]["latitude"]
            var longitude = data[i]["owner"]["location"]["longitude"]
            addMarkerToMap(data[i], icon, imageExtension, type, markersProject, latitude, longitude)
        }
    }
}
