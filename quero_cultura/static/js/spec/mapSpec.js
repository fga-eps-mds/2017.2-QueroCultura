describe('InitTime', function () {
	it('should get time with 3 hours and X minutes delay', function () {
		delay = -5;
		var now = InitTime(delay);

		var timeTest = new Date();
		timeTest.setHours(timeTest.getHours() - 3, timeTest.getMinutes() - delay);
		timeTest.setMilliseconds(0);
		timeTest = timeTest.toJSON();

		expect(now).toEqual(timeTest);

    });
});

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

describe("SpaceMarkers", function(){

	beforeEach(function(){
		imageExtension = "gif"
		minutes = 60
	});

	it("should add new space markers to map layer", function(){
		spyOn(map, "addLayer")

		SpaceMarkers(imageExtension, minutes)

		expect(map.addLayer).toHaveBeenCalledWith(markersSpace)
	});

	it("should load SpaceMarkers", function(){
		spyOn(window, "loadMarkers")

		SpaceMarkers(imageExtension, minutes)

		expect(window.loadMarkers).toHaveBeenCalledWith('space',imageExtension, minutes)
	});

	it("should clear layers", function(){
		spyOn(markersSpace, 'clearLayers')

		SpaceMarkers(imageExtension, minutes)

		expect(markersSpace.clearLayers).toHaveBeenCalledWith()
	});
});

describe("AgentMarkers", function(){
	beforeEach(function(){
		imageExtension = "png"
		minutes = 60
	});

	it("should add new agent markers to map layer", function(){
		spyOn(map, "addLayer")

		AgentMarkers(imageExtension, minutes)

		expect(map.addLayer).toHaveBeenCalledWith(markersAgent)
	});

	it("should load AgentMarkers", function(){
		spyOn(window, 'loadMarkers')

		AgentMarkers(imageExtension, minutes)

		expect(window.loadMarkers).toHaveBeenCalledWith('agent', imageExtension, minutes)
	});

	it("should clear layers", function(){
		spyOn(markersAgent, 'clearLayers')

		AgentMarkers(imageExtension, minutes)

		expect(markersAgent.clearLayers).toHaveBeenCalledWith()
	});
});

describe("EventMarkers", function(){
	beforeEach(function(){
		imageExtension = "png"
		minutes = 60
	});

	it("should add new event markers to map layer", function(){
		spyOn(map, "addLayer")

		EventMarkers(imageExtension, minutes)

		expect(map.addLayer).toHaveBeenCalledWith(markersEvent)
	});

	it("should load EventMarkers", function(){
		spyOn(window, 'loadMarkers')

		EventMarkers(imageExtension, minutes)

		expect(window.loadMarkers).toHaveBeenCalledWith('event', imageExtension, minutes)
	});

	it("should clear layers", function(){
		spyOn(markersEvent, 'clearLayers')

		EventMarkers(imageExtension, minutes)

		expect(markersEvent.clearLayers).toHaveBeenCalledWith()
	});
});

describe("ProjectMarkers", function(){

	beforeEach(function(){
		imageExtension = "png"
		minutes = 60
	})

	it("should add new markers to map layer", function(){
		spyOn(map,"addLayer")

		ProjectMarkers(imageExtension, minutes);

		expect(map.addLayer).toHaveBeenCalledWith(markersProject)
	})

	it("should load ProjectMarkers", function(){
		spyOn(window,'loadMarkers')

		ProjectMarkers(imageExtension, minutes);

		expect(window.loadMarkers).toHaveBeenCalledWith('project', imageExtension, minutes)
	})

	it("should clear layers", function(){
		spyOn(markersProject, 'clearLayers')

		ProjectMarkers(imageExtension, minutes)

		expect(markersProject.clearLayers).toHaveBeenCalledWith()
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

describe('MarkersPoints', function () {

	it('should add new agent marker point', function () {
    spyOn(window, 'AgentMarkers')

		MarkersPoints(true)

		expect(window.AgentMarkers).toHaveBeenCalledWith("png", 1440)
  });

	it('should add new event marker point', function () {
    spyOn(window, 'EventMarkers')

		MarkersPoints(true)

		expect(window.EventMarkers).toHaveBeenCalledWith("gif", 60)
  });

	it('should add new space marker point', function () {
    spyOn(window, 'SpaceMarkers')

		MarkersPoints(true)

		expect(window.SpaceMarkers).toHaveBeenCalledWith("png", 1440)
  });

	it('should add new project marker point', function () {
    spyOn(window, 'ProjectMarkers')

		MarkersPoints(true)

		expect(window.ProjectMarkers).toHaveBeenCalledWith("gif", 60)
  });

	it('should verify if has layer', function(){
		spyOn(map, 'hasLayer')

		MarkersPoints(true)

		expect(map.hasLayer).toHaveBeenCalledWith(markersAgent)
	});

	it('should verify if has layer', function(){
		spyOn(map, 'hasLayer')

		MarkersPoints(true)

		expect(map.hasLayer).toHaveBeenCalledWith(markersEvent)
	});

	it('should verify if has layer', function(){
		spyOn(map, 'hasLayer')

		MarkersPoints(true)

		expect(map.hasLayer).toHaveBeenCalledWith(markersSpace)
	});

	it('should verify if has layer', function(){
		spyOn(map, 'hasLayer')

		MarkersPoints(true)

		expect(map.hasLayer).toHaveBeenCalledWith(markersProject)
	});

	it('should update feed', function(){
		spyOn(window, 'updateFeed')

		MarkersPoints(true)

		expect(window.updateFeed).toHaveBeenCalledWith()
	});
});

describe('GetColorByType', function () {

	it('should add color by type agent', function () {
		type1 = 'agent'

		var color = GetColorByType(type1)

		expect(color).toEqual('#17a2b8')
	});

	it('should add color by type project', function () {

		type1 = 'project'

		var color = GetColorByType(type1)

		expect(color).toEqual('#28a745')

	});

	it('should add color by type space', function () {

		type1 = 'space'

		var color = GetColorByType(type1)

		expect(color).toEqual('#dc3545')
	});

	it('should add color by type event', function () {

		type1 = 'event'

		var color = GetColorByType(type1)

		expect(color).toEqual('#ffc107')

	});

	it('should add color by type default', function () {

		type1 = 'other'

		var color = GetColorByType(type1)

		expect(color).toEqual('black')

	});

});

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
		spyOn(window, 'loadMarkersInInstance')

		loadMarkers('agent', 'gif', '60')

		expect(window.loadMarkersInInstance).toHaveBeenCalled()
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
