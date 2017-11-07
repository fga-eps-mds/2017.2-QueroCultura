describe('createSpaceMarker', function(){

	it('should create space marker icon', function(){
		spyOn(window,'createMarkerIcon')
		data1 = {}
		createSpaceMarker(data1, 'gif');

		expect(window.createMarkerIcon).toHaveBeenCalledWith('red', 'gif')
	});

});

describe('createAgentMarker', function(){
	it('should create agent marker icon', function(){
		spyOn(window, 'createMarkerIcon')
		data1 = {}
		createAgentMarker(data1, 'png')

		expect(window.createMarkerIcon).toHaveBeenCalledWith('blue', 'png')
	});
});

describe('createEventMarker', function(){
	it('should create event marker icon', function(){
		spyOn(window, 'createMarkerIcon')
		data1 = {}
		createEventMarker(data1, 'gif')

		expect(window.createMarkerIcon).toHaveBeenCalledWith('yellow', 'gif')
	});
});

describe('createMarkerIcon', function(){
	it('should create red marker icon', function(){
		spyOn(L, 'icon')

		createMarkerIcon('red', 'gif')

		expect(L.icon).toHaveBeenCalledWith({ iconUrl: "static/images/"+"markerSpace"+"."+ "gif",
                    iconSize: [25,25]})
	});
	it('should create blue marker icon', function(){
		spyOn(L, 'icon')

		createMarkerIcon('blue', 'png')

		expect(L.icon).toHaveBeenCalledWith({ iconUrl: "static/images/"+"markerAgent"+"."+ "png",
                    iconSize: [25,25]
                 })
	});

	it('should create yellow marker icon', function(){
		spyOn(L, 'icon')

		createMarkerIcon('yellow', 'png')

		expect(L.icon).toHaveBeenCalledWith({ iconUrl: "static/images/"+"markerEvent"+"."+ "png",
                    iconSize: [25,25]
                 })
	});

	it('should create green marker icon', function(){
		spyOn(L, 'icon')

		createMarkerIcon('green', 'png')

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

describe('makeIdForMarker', function(){
		it('Should call getInitialInstance', function(){
			spyOn(window,'getInitialInstance')
			data = [{'id': 1, 'singleUrl': "http://spcultura.prefeitura.sp.gov.br/projeto/3304/"}]
			position = 0
			makeIdForMarker(data,position)
			expect(window.getInitialInstance).toHaveBeenCalled()
		});
		it('Should return identification', function(){
			data = [{'id': 1, 'singleUrl': "http://spcultura.prefeitura.sp.gov.br/projeto/3304/"}]
			position = 0
			identification = makeIdForMarker(data,position)
			equal = 'sp1'
			expect(identification).toEqual(equal)
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