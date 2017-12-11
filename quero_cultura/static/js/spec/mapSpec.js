describe('GetColorByType', function () {
	it('should return a blue for agent', function () {
		colorRGB = "#17a2b8";
		type = "agente";
    });

	it('should return a red for spaces', function () {
		colorRGB = "#dc3545";
		type = "espaco";
    });

	it('should return a green for project', function () {
		colorRGB = "#28a745";
		type = "projeto";
    });

	it('should return a yellow for event', function () {
		colorRGB = "#ffc107";
		type = "evento";
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

describe('AddHTMLToFeed', function () {

	xit('should get color by type', function () {

		spyOn(window,'GetColorByType')

		AddHTMLToFeed('James Bond', 'agent', '007');

		expect(window.GetColorByType).toHaveBeenCalledWith('agent')

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

// describe('saveAndLoadData', function(){
// 	xit('Should call createQueryPromise', function(){
// 		spyOn(window, 'createQueryPromise')
// 		saveAndLoadData('instanceURL', 'event', 5, [], 'gif')
// 		expect(window.createQueryPromise).toHaveBeenCalled()
// 	});
// });
//
// describe('loadAndUpdateMarkers', function(){
// 	it('Should call saveAndLoadData', function(){
// 		spyOn(window, 'saveAndLoadData')
// 		loadAndUpdateMarkers(5,[],'gif')
// 		expect(window.saveAndLoadData).toHaveBeenCalled()
// 	});
// 	it('Should call addLayer', function(){
// 		spyOn(map,'addLayer')
// 		loadAndUpdateMarkers(5,[],'gif')
// 		expect(map.addLayer).toHaveBeenCalledTimes(4)
// 	});
// });

describe('initialize_data_map', function() {
	it('Should initialize map data', function(){
		var test = {}
		var equal = initialize_data_map()
		expect(typeof test).toEqual(typeof equal)
	});
})
