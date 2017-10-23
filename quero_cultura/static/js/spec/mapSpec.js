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
