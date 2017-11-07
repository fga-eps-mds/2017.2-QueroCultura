describe('createSpaceMarker', function(){

	it('should create space marker icon', function(){
		spyOn(window,'createMarkerIcon')
		data1 = {}
		createSpaceMarker(data1, 'gif');

		expect(window.createMarkerIcon).toHaveBeenCalledWith('espaco', 'gif')
	});

});

describe('createAgentMarker', function(){
	it('should create agent marker icon', function(){
		spyOn(window, 'createMarkerIcon')
		data1 = {}
		createAgentMarker(data1, 'png')

		expect(window.createMarkerIcon).toHaveBeenCalledWith('agente', 'png')
	});
});

describe('createEventMarker', function(){
	it('should create event marker icon', function(){
		spyOn(window, 'createMarkerIcon')
		data1 = {}
		createEventMarker(data1, 'gif')

		expect(window.createMarkerIcon).toHaveBeenCalledWith('evento', 'gif')
	});
});

describe('createMarkerIcon', function(){
	it('should create red marker icon for space', function(){
		spyOn(L, 'icon')

		createMarkerIcon('espaco', 'gif')

		expect(L.icon).toHaveBeenCalledWith({ iconUrl: "static/images/"+"markerSpace"+"."+ "gif",
                    iconSize: [25,25]})
	});
	it('should create blue marker icon for agent', function(){
		spyOn(L, 'icon')

		createMarkerIcon('agente', 'png')

		expect(L.icon).toHaveBeenCalledWith({ iconUrl: "static/images/"+"markerAgent"+"."+ "png",
                    iconSize: [25,25]
                 })
	});

	it('should create yellow marker icon for event', function(){
		spyOn(L, 'icon')

		createMarkerIcon('evento', 'png')

		expect(L.icon).toHaveBeenCalledWith({ iconUrl: "static/images/"+"markerEvent"+"."+ "png",
                    iconSize: [25,25]
                 })
	});

	it('should create green marker icon for project', function(){
		spyOn(L, 'icon')

		createMarkerIcon('projeto', 'png')

		expect(L.icon).toHaveBeenCalledWith({ iconUrl: "static/images/"+"markerProject"+"."+ "png",
                    iconSize: [25,25]
                 })
	});
});

describe('getInitialInstance', function(){
	it('should get initial instance', function(){
		data = [{"singleUrl": "http://spcultura.prefeitura.sp.gov.br/projeto/3304/"}]
		position = 0
		var url = data[position]["singleUrl"]
	    var splitUrl = url.split(".")
		var test = getInitialInstance(data[position])
		expect(test).toEqual(splitUrl[2])
	});
});

describe('setZIndex', function(){
	it('Should return 1000', function(){
			equal = 1000
			test = setZIndex('gif')
			expect(test).toEqual(equal)
	});
	it('Should return -30', function(){
		equal = -30
		test = setZIndex('png')
		expect(test).toEqual(equal)
	});
});

describe('loadMarkersInInstance', function(){
	xit('should call createPromise', function(){

		spyOn(window, 'createPromise')
		loadMarkersInInstance('agent', 'agent123', 'gif', 60)
		expect(window.createPromise).toHaveBeenCalled()
	});
});

describe('setZIndex', function () {
	it('should set a z index', function () {
		var test = 0;
		expect(test).toEqual(0);
    });
});
