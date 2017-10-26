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

function createSpaceMarker(data, imageExtension){
    var redMarker = createMarkerIcon('red', imageExtension)

    for(var i=0; i < data.length; i++){

        if(data[i]["location"] != null){
          if(imageExtension == "gif"){
            data[i]["type"] = "space"
            var idForMarker = makeIdForMarker(data,i)
            newMarkers.set(idForMarker, data[i])
            var marker = L.marker([data[i]["location"]["latitude"],
                                    data[i]["location"]["longitude"]],
                                    {icon: redMarker}).setZIndexOffset(1000).addTo(markersSpace);
            marker.bindPopup('<h6><b>Nome:</b></h6>'+data[i]["name"]+'<h6><b>Link:</b></h6><a target="_blank" href='+data[i]["singleUrl"]+'>Clique aqui</a>');
            identifiedMarker = {"id" : data[i].id,"marker" : marker}
            printedMarkers.push(identifiedMarker)
          }else{
            data[i]["type"] = "space"
            var idForMarker = makeIdForMarker(data,i)
            newMarkers.set(idForMarker, data[i])
            var marker = L.marker([data[i]["location"]["latitude"],
            data[i]["location"]["longitude"]],
            {icon: redMarker}).setZIndexOffset(-30).addTo(markersSpace);
            marker.bindPopup('<h6><b>Nome:</b></h6>'+data[i]["name"]+'<h6><b>Link:</b></h6><a target="_blank" href='+data[i]["singleUrl"]+'>Clique aqui</a>');
            identifiedMarker = {"id" : data[i].id,"marker" : marker}
            printedMarkers.push(identifiedMarker)
          }
        }
    }
}

function createAgentMarker(data, imageExtension){
    var blueMarker = createMarkerIcon('blue', imageExtension)
    for(var i=0; i < data.length; i++){

        if(imageExtension == "gif"){

          if(data[i]["location"] != null){
            data[i]["type"] = "agent"
            var idForMarker = makeIdForMarker(data,i)
            newMarkers.set(idForMarker, data[i])
            var marker = L.marker([data[i]["location"]["latitude"],
            data[i]["location"]["longitude"]],
            {icon: blueMarker}).setZIndexOffset(1000).addTo(markersAgent)
            marker.bindPopup('<h6><b>Nome:</b></h6>'+data[i]["name"]+'<h6><b>Link:</b></h6><a target="_blank" href='+data[i]["singleUrl"]+'>Clique aqui</a>');
            identifiedMarker = {"id" : data[i].id,"marker" : marker}
            printedMarkers.push(identifiedMarker)
          }
        }else{
          data[i]["type"] = "agent"
          var idForMarker = makeIdForMarker(data,i)
          newMarkers.set(idForMarker, data[i])
          var marker = L.marker([data[i]["location"]["latitude"],
          data[i]["location"]["longitude"]],
          {icon: blueMarker}).setZIndexOffset(-30).addTo(markersAgent)
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
          if(imageExtension == "gif"){

            data[i]["type"] = "event"
            var idForMarker = makeIdForMarker(data,i)
            newMarkers.set(idForMarker, data[i])
            var marker = L.marker([data[i]["occurrences"][0]["space"]["location"]["latitude"],
            data[i]["occurrences"][0]["space"]["location"]["longitude"]],
            {icon: yellowMarker}).setZIndexOffset(1000).addTo(markersEvent);
            marker.bindPopup('<h6><b>Nome:</b></h6>'+data[i]["name"]+'<h6><b>Link:</b></h6><a target="_blank" href='+data[i]["singleUrl"]+'>Clique aqui</a>');
            identifiedMarker = {"id" : data[i].id,"marker" : marker}
            printedMarkers.push(identifiedMarker)
          }else{

            data[i]["type"] = "event"
            var idForMarker = makeIdForMarker(data,i)
            newMarkers.set(idForMarker, data[i])
            var marker = L.marker([data[i]["occurrences"][0]["space"]["location"]["latitude"],
            data[i]["occurrences"][0]["space"]["location"]["longitude"]],
            {icon: yellowMarker}).setZIndexOffset(-30).addTo(markersEvent);
            marker.bindPopup('<h6><b>Nome:</b></h6>'+data[i]["name"]+'<h6><b>Link:</b></h6><a target="_blank" href='+data[i]["singleUrl"]+'>Clique aqui</a>');
            identifiedMarker = {"id" : data[i].id,"marker" : marker}
            printedMarkers.push(identifiedMarker)
          }
    	}
    }
}

function createProjectMarker(data, imageExtension){
    var greenMarker = createMarkerIcon('green', imageExtension)

    for(var i=0; i < data.length; i++){
    	if(data[i]["owner"] != null){
        if(imageExtension == "gif"){
          data[i]["type"] = "project"
          var idForMarker = makeIdForMarker(data,i)
          newMarkers.set(idForMarker, data[i])
        	var marker = L.marker([data[i]["owner"]["location"]["latitude"],
        							data[i]["owner"]["location"]["longitude"]],
        							{icon: greenMarker}).setZIndexOffset(1000).addTo(markersProject);
        	marker.bindPopup('<h6><b>Nome:</b></h6>'+data[i]["name"]+'<h6><b>Link:</b></h6><a target="_blank" href='+data[i]["singleUrl"]+'>Clique aqui</a>');
            identifiedMarker = {"id" : data[i].id,"marker" : marker}
            printedMarkers.push(identifiedMarker)
        }


        }else{

          data[i]["type"] = "project"
          var idForMarker = makeIdForMarker(data,i)
          newMarkers.set(idForMarker, data[i])
          var marker = L.marker([data[i]["owner"]["location"]["latitude"],
          data[i]["owner"]["location"]["longitude"]],
          {icon: greenMarker}).setZIndexOffset(-30).addTo(markersProject);
          marker.bindPopup('<h6><b>Nome:</b></h6>'+data[i]["name"]+'<h6><b>Link:</b></h6><a target="_blank" href='+data[i]["singleUrl"]+'>Clique aqui</a>');
          identifiedMarker = {"id" : data[i].id,"marker" : marker}
          printedMarkers.push(identifiedMarker)
        }
      }
}

