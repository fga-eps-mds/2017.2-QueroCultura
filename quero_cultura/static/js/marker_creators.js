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

    // Check if exist an subsite link, if exist, change url to subsite.
    if(data.subsite == null){
        //In normal flux, doesn't exist subsite and we use "singleUrl"
        var popup = '<h6><b>Nome:</b></h6>'+data.name+
                    '<h6><b>Link:</b></h6><a target="_blank" href='+data.singleUrl+'>Clique aqui</a>'
        marker.bindPopup(popup);
    }else{
        // remove a marker type to url
        var splitUrl = data.singleUrl.split("/")
        type = splitUrl[3]

        instanceUrl = splitUrl[0]+"//"+splitUrl[2]

        var promise = requestSubsite(instanceUrl+'/api/subsite/find', data.subsite)
        promise.then(function(subsiteData) {
            linkSubsite = "http://"+subsiteData[0]["url"] + "/"+type+"/" + data.id
            var popup = '<h6><b>Nome:</b></h6>'+data.name+
                        '<h6><b>Link:</b></h6><a target="_blank" href='+linkSubsite+'>Clique aqui</a>'
            marker.bindPopup(popup);
        });
    }
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

    for(var i=0; i < data.length; i++){
        if(data[i]["location"]){
            data[i]["type"] = "espaco"
            var latitude = data[i]["location"]["latitude"]
            var longitude = data[i]["location"]["longitude"]
            addMarkerToMap(data[i], icon, imageExtension, markersSpace, latitude, longitude)
        }
    }
}

/* Create a agent marker and add into map
   receiving an 'data' that constains agent informations obtained of api
*/
function createAgentMarker(data, imageExtension){
    var icon = createMarkerIcon('agente', imageExtension)

    for(var i=0; i < data.length; i++){
        if(data[i]["location"]){
            data[i]["type"] = "agente"
            var latitude = data[i]["location"]["latitude"]
            var longitude = data[i]["location"]["longitude"]
            addMarkerToMap(data[i], icon, imageExtension, markersAgent, latitude, longitude)
        }
    }
}

/* Create a event marker and add into map
   receiving an 'data' that constains event informations obtained of api
*/
function createEventMarker(data, imageExtension){
    var icon = createMarkerIcon('evento', imageExtension)

    for(var i=0; i < data.length; i++){
        data[i]["type"] = "evento"
    	if((data[i]["occurrences"]).length){
            var latitude = data[i]["occurrences"][0]["space"]["location"]["latitude"]
            var longitude = data[i]["occurrences"][0]["space"]["location"]["longitude"]
            addMarkerToMap(data[i], icon, imageExtension, markersEvent, latitude, longitude)
	    }
    }
}

/* Create a project marker and add into map
   receiving an 'data' that constains project informations obtained of api
*/
function createProjectMarker(data, imageExtension){
    var icon = createMarkerIcon('projeto', imageExtension)

    for(var i=0; i < data.length; i++){
        if(data[i]["owner"]){
            data[i]["type"] = "projeto"
            var latitude = data[i]["owner"]["location"]["latitude"]
            var longitude = data[i]["owner"]["location"]["longitude"]
            addMarkerToMap(data[i], icon, imageExtension, markersProject, latitude, longitude)
        }
    }
}
