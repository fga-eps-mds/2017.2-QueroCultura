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

		expect(window.loadMarkers).toHaveBeenCalledWith('project',imageExtension, minutes)
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
