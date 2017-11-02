
describe('GetColorByType', function () {
	it('should return a blue for agent', function () {
		colorRGB = "#17a2b8";
		type = "agent";
    });

	it('should return a red for spaces', function () {
		colorRGB = "#dc3545";
		type = "space";
    });

	it('should return a green for project', function () {
		colorRGB = "#28a745";
		type = "project";
    });

	it('should return a yellow for event', function () {
		colorRGB = "#ffc107";
		type = "event";
	});

	it('should return a black for anything wrong and not classified', function(){
		colorRGB = "black";
		type = "EscreviErradoOType";
	});

	afterEach(function(){
		color = GetColorByType(type);
		expect(color).toEqual(colorRGB);
	});
});

describe("AddInfoToFeed", function(){

	it("should get all data", function(){
		diffFeed2 = new Map()
		diffFeed2.set(123,{"name":"Pablo","type":"Agente","singleUrl":"teste"})
		diffFeed2.set(1234,{"name":"Pablo2","type":"Agente2","singleUrl":"teste2"})

		spyOn(diffFeed2,'forEach')

		AddInfoToFeed(diffFeed2);

		expect(diffFeed2.forEach).toHaveBeenCalled()
	})
})

describe('AddHTMLToFeed', function () {

	it('should get color by type', function () {

		spyOn(window,'GetColorByType')

		AddHTMLToFeed('James Bond', 'agent', '007');

		expect(window.GetColorByType).toHaveBeenCalledWith('agent')

	});

});

describe('updateFeed', function(){

	it("should add diffFeed to feed", function(){
		newMarkers1 = new Map()

		spyOn(window,'AddInfoToFeed')

		updateFeed();

		expect(window.AddInfoToFeed).toHaveBeenCalled()
	});
});

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

describe('loadMarkers', function(){
	it('should load markers in instance', function(){
		spyOn(window, 'createProjectMarker')

		loadMarkers('project', 'gif', '60')

		expect(window.createProjectMarker).toHaveBeenCalled()
	});
	it('should load markers in instance', function(){
		spyOn(window, 'createEventMarker')

		loadMarkers('event', 'gif', '60')

		expect(window.createEventMarker).toHaveBeenCalled()
	});
	it('should load markers in instance', function(){
		spyOn(window, 'createAgentMarker')

		loadMarkers('agent', 'gif', '60')

		expect(window.createAgentMarker).toHaveBeenCalled()
	});
	it('should load markers in instance', function(){
		spyOn(window, 'createSpaceMarker')

		loadMarkers('space', 'gif', '60')

		expect(window.createSpaceMarker).toHaveBeenCalled()
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

describe('eraseCookie', function(){

	it('should erase cookie', function(){

		spyOn(window, 'writeCookie')

		eraseCookie('nome')

		expect(window.writeCookie).toHaveBeenCalledWith('nome', '', -1)
	});
});

describe('readCookie', function(){
	it('should read cookie', function(){
		var test = readCookie('dontExist01020304')

		expect(test).toEqual(null)
	});
});

describe('getQueryDateTime', function() {
	it('should create a new date time', function () {
		delay = -5;
		var now = getQueryDateTime(delay);
		var timeTest = new Date();

		timeTest.setHours(timeTest.getHours() - 3, timeTest.getMinutes() - delay);
		timeTest = timeTest.toJSON();

		expect(now).toEqual(timeTest);

    });
});

describe('createQueryPromise',function(){
	it('Should call getQueryDateTime', function(){
		spyOn(window, 'getQueryDateTime')
		createQueryPromise('instanceURL','event',5)
		expect(window.getQueryDateTime).toHaveBeenCalledWith(5)
	});
	xit('Should return promise',function(){
		var dateTime = getQueryDateTime(5)
		var select = 'name, occurrences.{space.{location}}, singleUrl'
		var promise = $.getJSON("instanceURLevent/find",
	      {
	        '@select' : select,
	        '@or' : 1,
	        'createTimestamp' : "GT("+dateTime+")",
	        'updateTimestamp' : "GT("+dateTime+")"
	      },);
		  var equal = createQueryPromise('instanceURL','event',5)
		  expect(equal).toEqual(promise)
	});
});

describe('saveAndLoadData', function(){
	xit('Should call createQueryPromise', function(){
		spyOn(window, 'createQueryPromise')
		saveAndLoadData('instanceURL', 'event', 5, [], 'gif')
		expect(window.createQueryPromise).toHaveBeenCalled()
	});
});

describe('loadAndUpdateMarkers', function(){
	it('Should call saveAndLoadData', function(){
		spyOn(window, 'saveAndLoadData')
		loadAndUpdateMarkers(5,[],'gif')
		expect(window.saveAndLoadData).toHaveBeenCalled()
	});
	it('Should call checkMarkersDuplicity', function(){
		spyOn(window, 'checkMarkersDuplicity')
		loadAndUpdateMarkers(5,[],'gif')
		expect(window.checkMarkersDuplicity).toHaveBeenCalledWith(lastHourData)
	});
	it('Should call addLayer', function(){
		spyOn(map,'addLayer')
		loadAndUpdateMarkers(5,[],'gif')
		expect(map.addLayer).toHaveBeenCalledTimes(4)
	});
	it('Should call updateFeed', function(){
		spyOn(window, 'updateFeed')
		loadAndUpdateMarkers(5,[],'gif')
		expect(window.updateFeed).toHaveBeenCalledWith()
	});
});

describe('checkMarkersDuplicity', function(){
	xit('should remove layers', function(){
		spyOn(map, 'removeLayer')
		var value = Array()
		value.push({id: 29883, name: "Guilherme Mauricio Monteiro", singleUrl: "http://spcultura.prefeitura.sp.gov.br/agente/29883/", type: "agent"})
		value.push({id: 29883, name: "Guilherme Mauricio Monteiro", singleUrl: "http://spcultura.prefeitura.sp.gov.br/agente/29883/", type: "agent"})


		checkMarkersDuplicity(value)
		expect(map.removeLayer).toHaveBeenCalled()
	});
});

describe('getInitialInstance', function(){
	it('should get initial instance', function(){
		data = [{'singleUrl': "http://spcultura.prefeitura.sp.gov.br/projeto/3304/"}]
		position = 0
		var url = data[position]["singleUrl"]
	    var splitUrl = url.split(".")
		var test = getInitialInstance(data, position)

		expect(test).toEqual(splitUrl[2])
	});
});
