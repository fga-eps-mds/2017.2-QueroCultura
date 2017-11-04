var newMarkers = new Map()
var printedFeed = new Map()
var diffFeed = new Map()

// variable that contains the subsites of mapas.cultura.gov.br(Mapas BR) with yours respectives id's
// These can be obtained in follow link: 'http://mapas.cultura.gov.br/api/subsite/find?@select=url'
var subsites = {1:"museus.cultura.gov.br",
                2:"bibliotecas.cultura.gov.br",
                4:"mapas.cultura.gov.br",
                9:"mapacultural.es.gov.br",
                11:"pb.mapas.cultura.gov.br",
                12:"ma.mapas.cultura.gov.br",
                15:"pa.mapas.cultura.gov.br",
                16:"jaguarao.rs.mapas.cultura.gov.br",
                17:"meleva.cultura.gov.br",
                18:"grucultura.guarulhos.sp.gov.br",
                20:"laguna.sc.mapas.cultura.gov.br",
                21:"mapa.cultura.aracaju.se.gov.br",
                22:"francodarocha.sp.mapas.cultura.gov.br",
                23:"mapacultural.itu.sp.gov.br",
                24:"ba.mapas.cultura.gov.br",
                25:"mapacultural.parnaiba.pi.gov.br",
                26:"osasco.sp.mapas.cultura.gov.br",
                27:"camacari.ba.mapas.cultura.gov.br",
                28:"ilheus.ba.mapas.cultura.gov.br",
                29:"varzeagrande.mt.mapas.cultura.gov.br",
                30:"pontosdememoria.cultura.gov.br",
                31:"mapadaculturafoz.pmfi.pr.gov.br",
                32:"senhordobonfim.ba.mapas.cultura.gov.br",
                33:"mapas.cultura.se.gov.br",
                34:"mapacultural.itapetininga.sp.gov.br",
                35:"mapacultural.ipatinga.mg.gov.br",
                36:"mapacultural.novohamburgo.rs.gov.br",
                37:"mapacultural.saocaetanodosul.sp.gov.br"}

// Contains markers printed on map
var printedMarkers = Array()

/* Add an marker icon to the map
   considering the icon extension
*/
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

/* Return a string with the subsite's url, using an subsiteId
*/
function getSubsite(subsiteId){
    //http://mapas.cultura.gov.br/api/subsite/find?%40select=url&id=eq(37)
    
    /*
    response = $.getJSON('http://mapas.cultura.gov.br/api/subsite/find',
        {
        '@select' : 'url',
        'id': 'eq('+subsiteId+')'
    });

    return response
    */

    subsite = subsites[subsiteId].toString()
    return subsite
}

/* Return instance initials
*/
function getInitialInstance(data,position){
  var url = data[position]["singleUrl"]
  var splitUrl = url.split(".")
  return splitUrl[2]
}

/*  Create an ID to identify the marker when added to the map
*/
function makeIdForMarker(data,position){
  var initialsInstance = getInitialInstance(data,position)
  var id = data[position]["id"]
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
    var popup = '<h6><b>Load Error</b></h6>'

    // Check if exist an subsite link, if exist, change url to subsite.
    if(data.subsite == null){
        //In normal flux, doesn't exist subsite and we use "singleUrl"
        popup = '<h6><b>Nome:</b></h6>'+data.name+
                '<h6><b>Link:</b></h6><a target="_blank" href='+data.singleUrl+'>Clique aqui</a>'
    }else{
        linkSubsite = "http://"+getSubsite(data.subsite) + "/"+type+"/" + data.id
        popup = '<h6><b>Subsite:</b></h6>'+data.subsite+
                '<h6><b>Nome:</b></h6>'+data.name+
                '<h6><b>Link:</b></h6><a target="_blank" href='+linkSubsite+'>Clique aqui</a>'
    }

    marker.bindPopup(popup);
}

/* Create a space marker and add into map
   receiving an 'data' that constains space informations obtained of api
*/
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

            createPopup("espaco",data[i],marker)

            identifiedMarker = {"id" : data[i].id,"marker" : marker}
            printedMarkers.push(identifiedMarker)
        }
    }
}

/* Create a agent marker and add into map
   receiving an 'data' that constains agent informations obtained of api
*/
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

            createPopup("agente",data[i],marker)

            identifiedMarker = {"id" : data[i].id,"marker" : marker}
            printedMarkers.push(identifiedMarker)
        }
    }
}

/* Create a event marker and add into map
   receiving an 'data' that constains event informations obtained of api
*/
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

            createPopup("evento",data[i],marker)

            identifiedMarker = {"id" : data[i].id,"marker" : marker}
            printedMarkers.push(identifiedMarker)
    	  }
    }
}

/* Create a project marker and add into map
   receiving an 'data' that constains project informations obtained of api
*/
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

            createPopup("projeto",data[i],marker)

            identifiedMarker = {"id" : data[i].id,"marker" : marker}
            printedMarkers.push(identifiedMarker)
        }
    }
}
