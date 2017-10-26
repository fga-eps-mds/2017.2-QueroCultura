function createPromise(url, type, minutes){
    var getTimeNow = InitTime(minutes);

    select = ''
    switch(type){
        case 'event': select = 'name, occurrences.{space.{location}}, singleUrl'
            break
        case 'project': select = 'name, owner.location, singleUrl '
            break
        case 'space':
        case 'agent':
            select = 'name, location, singleUrl'
            break
    }

    var promise = $.getJSON(url,
      {
        '@select' : select,
        '@or' : 1,
        'createTimestamp' : "GT("+getTimeNow+")",
        'updateTimestamp' : "GT("+getTimeNow+")"
      })
      return promise
}

function loadMarkers(type, imageExtension, minutes){
    loadMarkersInInstance(type,'http://mapas.cultura.gov.br/api/'+type+'/find' ,imageExtension,minutes)
    loadMarkersInInstance(type,'http://spcultura.prefeitura.sp.gov.br/api/'+type+'/find' ,imageExtension,minutes)
    loadMarkersInInstance(type,'http://mapa.cultura.ce.gov.br/api/'+type+'/find' ,imageExtension,minutes)

}

function loadMarkersInInstance(type, url, imageExtension, minutes) {
    var promise = createPromise(url, type, minutes)

    promise.then(function(data) {
        switch (type) {
            case 'project': createProjectMarker(data, imageExtension)
            break
            case 'event': createEventMarker(data, imageExtension)
            break
            case 'agent': createAgentMarker(data, imageExtension)
            break
            case 'space': createSpaceMarker(data, imageExtension)
            break
        }
    });
}
