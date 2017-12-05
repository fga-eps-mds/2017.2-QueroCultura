// Contains markers printed on map
var printedMarkers = Array()

/* Add an marker icon to the map
   considering the icon extension
*/
function createMarkerIcon(markerType, extension){
    filename = ''
    switch (markerType) {
        case 'espaco': filename = 'markerSpace'
            break
        case 'agente': filename = 'markerAgent'
            break
        case 'evento': filename = 'markerEvent'
            break
        case 'projeto': filename = 'markerProject'
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

/* Return instance initials
*/
function getInitialInstance(data){
  var url = data["singleUrl"]
  var splitUrl = url.split(".")
  return splitUrl[2]
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

/* this responpose get a subsite link for a instanceUrl
remember that mapas br and ceara instances have subsites
*/
function requestSubsite(url, subsiteID){
    if (subsiteID == null || subsiteID == "null"){
        subsiteID = 0
    }
    response = $.getJSON(url,
    {
        '@select' : 'url',
        'id': 'eq('+subsiteID+')'
    })
    return response
}

/* Create a popup to marker
*/
function createPopup(data,marker){
    var popup = '<h6><b>Nome:</b></h6>'+data.name+
                '<h6><b>Link:</b></h6><a target="_blank" href='+data.instance_url+'>Clique aqui</a>'
    marker.bindPopup(popup);
}

function addMarkerToMap(data, icon, imageExtension, featureGroup, latitude, longitude){
    var valueZindex = setZIndex(imageExtension)

    // Instantiates a Marker object given a geographical point and optionally an options object
    var marker = L.marker([latitude, longitude], {icon: icon}).setZIndexOffset(valueZindex).addTo(featureGroup);

    createPopup(data,marker)
    var identifiedMarker = {"id" : data.id,"marker" : marker}
    printedMarkers.push(identifiedMarker)
}

/* Create a space marker and add into map
   receiving an 'data' that constains space informations obtained of api
*/
function createSpaceMarker(data, imageExtension){
    var icon = createMarkerIcon('espaco', imageExtension)

    if(data["location"]){
        data["type"] = "espaco"
        var latitude = data["location"]["latitude"]
        var longitude = data["location"]["longitude"]
        addMarkerToMap(data, icon, imageExtension, markersSpace, latitude, longitude)
    }
}

/* Create a agent marker and add into map
   receiving an 'data' that constains agent informations obtained of api
*/
function createAgentMarker(data, imageExtension){
    var icon = createMarkerIcon('agente', imageExtension)

    if(data["location"]){
        data["type"] = "agente"
        var latitude = data["location"]["latitude"]
        var longitude = data["location"]["longitude"]
        addMarkerToMap(data, icon, imageExtension, markersAgent, latitude, longitude)
    }
}

/* Create a event marker and add into map
   receiving an 'data' that constains event informations obtained of api
*/
function createEventMarker(data, imageExtension){
    var icon = createMarkerIcon('evento', imageExtension)

    data["type"] = "evento"
    if(data["location"]){
	   addMarkerToMap(data, icon, imageExtension, markersEvent,
                      data['location'].latitude, data['location'].longitude)
    }
}

/* Create a project marker and add into map
   receiving an 'data' that constains project informations obtained of api
*/
function createProjectMarker(data, imageExtension){
    var icon = createMarkerIcon('projeto', imageExtension)

    data["type"] = "projeto"
    if(data["location"]){
        addMarkerToMap(data, icon, imageExtension, markersProject,
                       data['location'].latitude, data['location'].longitude)
    }
}
