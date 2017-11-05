var newMarkers = new Map()
var printedFeed = new Map()
var diffFeed = new Map()

var printedMarkers = Array()

function createMarkerIcon(color, extension){
    filename = ''
    switch (color) {
        case 'red': filename = 'markerSpace'
            break
        case 'blue': filename = 'markerAgent'
            break
        case 'yellow': filename = 'markerEvent'
            break
        case 'green': filename = 'markerProject'
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


// this function  return instance initials
function getInitialInstance(data,position){
  var url = data[position]["singleUrl"]
  var splitUrl = url.split(".")
  return splitUrl[2]
}
function makeIdForMarker(data,position){

  var initialsInstance = getInitialInstance(data,position)
  var id = data[position]["id"]
  var idString = id.toString()
  var identification = initialsInstance+idString
  return identification
}

function setZIndex(imageExtension){
  if(imageExtension == "gif"){
    return 1000
  }else{
    return -30
  }
}

function createSpaceMarker(data, imageExtension){
    var redMarker = createMarkerIcon('red', imageExtension)

    for(var i=0; i < data.length; i++){

        if(data[i]["location"] != null){
          var valueZindex = setZIndex(imageExtension)
            data[i]["type"] = "space"
            var idForMarker = makeIdForMarker(data,i)
            newMarkers.set(idForMarker, data[i])
            var marker = L.marker([data[i]["location"]["latitude"],
                                    data[i]["location"]["longitude"]],
                                    {icon: redMarker}).setZIndexOffset(valueZindex).addTo(markersSpace);
            marker.bindPopup('<h6><b>Nome:</b></h6>'+data[i]["name"]+'<h6><b>Link:</b></h6><a target="_blank" href='+data[i]["singleUrl"]+'>Clique aqui</a>');
            identifiedMarker = {"id" : data[i].id,"marker" : marker}
            printedMarkers.push(identifiedMarker)
        }
    }
}

function createAgentMarker(data, imageExtension){
    var blueMarker = createMarkerIcon('blue', imageExtension)
    for(var i=0; i < data.length; i++){

          if(data[i]["location"] != null){
            data[i]["type"] = "agent"
            var idForMarker = makeIdForMarker(data,i)
            var valueZindex = setZIndex(imageExtension)
            newMarkers.set(idForMarker, data[i])
            var marker = L.marker([data[i]["location"]["latitude"],
                                   data[i]["location"]["longitude"]],
                                   {icon: blueMarker}).setZIndexOffset(valueZindex).addTo(markersAgent)
            marker.bindPopup('<h6><b>Nome:</b></h6>'+data[i]["name"]+'<h6><b>Link:</b></h6><a target="_blank" href='+data[i]["singleUrl"]+'>Clique aqui</a>');
            identifiedMarker = {"id" : data[i].id,"marker" : marker}
            printedMarkers.push(identifiedMarker)
          }
  }
}

function createEventMarker(data, imageExtension){
    var yellowMarker = createMarkerIcon('yellow', imageExtension)

    for(var i=0; i < data.length; i++){
    	if((data[i]["occurrences"]).length != 0){

            data[i]["type"] = "event"
            var idForMarker = makeIdForMarker(data,i)
            var valueZindex = setZIndex(imageExtension)
            newMarkers.set(idForMarker, data[i])
            var marker = L.marker([data[i]["occurrences"][0]["space"]["location"]["latitude"],
            data[i]["occurrences"][0]["space"]["location"]["longitude"]],
            {icon: yellowMarker}).setZIndexOffset(valueZindex).addTo(markersEvent);
            marker.bindPopup('<h6><b>Nome:</b></h6>'+data[i]["name"]+'<h6><b>Link:</b></h6><a target="_blank" href='+data[i]["singleUrl"]+'>Clique aqui</a>');
            identifiedMarker = {"id" : data[i].id,"marker" : marker}
            printedMarkers.push(identifiedMarker)

    	}
    }
}

function createProjectMarker(data, imageExtension){
    var greenMarker = createMarkerIcon('green', imageExtension)

    for(var i=0; i < data.length; i++){
    	if(data[i]["owner"] != null){
          data[i]["type"] = "project"
          var idForMarker = makeIdForMarker(data,i)
          var valueZindex = setZIndex(imageExtension)

          newMarkers.set(idForMarker, data[i])
        	var marker = L.marker([data[i]["owner"]["location"]["latitude"],
        							data[i]["owner"]["location"]["longitude"]],
        							{icon: greenMarker}).setZIndexOffset(valueZindex).addTo(markersProject);
        	marker.bindPopup('<h6><b>Nome:</b></h6>'+data[i]["name"]+'<h6><b>Link:</b></h6><a target="_blank" href='+data[i]["singleUrl"]+'>Clique aqui</a>');
            identifiedMarker = {"id" : data[i].id,"marker" : marker}
            printedMarkers.push(identifiedMarker)
        }
      }
}
