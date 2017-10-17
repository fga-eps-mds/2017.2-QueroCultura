var newMarkers = new Map()
var printedFeed = new Map()
var diffFeed = new Map()

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

    return L.icon({ iconUrl: "static/images/"+filename+"."+ extension,
                    iconSize: [25,25],
                 });
}

function createSpaceMarker(data, imageExtension){
    var redMarker = createMarkerIcon('red', imageExtension)

    for(var i=0; i < data.length; i++){
        if(data[i]["location"] != null){
            newMarkers.set(data[i]["id"], data[i])
            var marker = L.marker([data[i]["location"]["latitude"],
                                    data[i]["location"]["longitude"]],
                                    {icon: redMarker}).addTo(markersSpace);
            marker.bindPopup('<h6><b>Nome:</b></h6>'+data[i]["name"]+'<h6><b>Link:</b></h6><a target="_blank" href='+data[i]["singleUrl"]+'>Clique aqui</a>');
        }
    }
}

function createAgentMarker(data, imageExtension){
    var blueMarker = createMarkerIcon('blue', imageExtension)

    for(var i=0; i < data.length; i++){

        if(data[i]["location"] != null){
            newMarkers.set(data[i]["id"], data[i])
        	var marker = L.marker([data[i]["location"]["latitude"],
        							data[i]["location"]["longitude"]],
        							{icon: blueMarker}).addTo(markersAgent);
        	marker.bindPopup('<h6><b>Nome:</b></h6>'+data[i]["name"]+'<h6><b>Link:</b></h6><a target="_blank" href='+data[i]["singleUrl"]+'>Clique aqui</a>');
    	}
    }
}

function createEventMarker(data, imageExtension){
    var yellowMarker = createMarkerIcon('yellow', imageExtension)

    for(var i=0; i < data.length; i++){
    	if((data[i]["occurrences"]).length != 0){
            newMarkers.set(data[i]["id"], data[i])
        	var marker = L.marker([data[i]["occurrences"][0]["space"]["location"]["latitude"],
        							data[i]["occurrences"][0]["space"]["location"]["longitude"]],
        							{icon: yellowMarker}).addTo(markersEvent);
        	marker.bindPopup('<h6><b>Nome:</b></h6>'+data[i]["name"]+'<h6><b>Link:</b></h6><a target="_blank" href='+data[i]["singleUrl"]+'>Clique aqui</a>');
    	}
    }
}

function createProjectMarker(data, imageExtension){
    var greenMarker = createMarkerIcon('green', imageExtension)

    for(var i=0; i < data.length; i++){
    	if(data[i]["owner"] != null){
            newMarkers.set(data[i]["id"], data[i])
        	var marker = L.marker([data[i]["owner"]["location"]["latitude"],
        							data[i]["owner"]["location"]["longitude"]],
        							{icon: greenMarker}).addTo(markersProject);
        	marker.bindPopup('<h6><b>Nome:</b></h6>'+data[i]["name"]+'<h6><b>Link:</b></h6><a target="_blank" href='+data[i]["singleUrl"]+'>Clique aqui</a>');
    	}
    }

}
