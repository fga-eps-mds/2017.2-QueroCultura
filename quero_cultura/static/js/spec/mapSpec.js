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

describe('AddHTMLToFeed', function () {
	it('should return html', function () {
        var marker = {"name": "Jeferson",
        			"marker_type": "agent",
        			"instance_url": "http://mapas.cultura.gov.br/agente/1",
        			"action_type": "test",
        			"action_time": "testagain",
        			"city": "Brasilia",
        			"state": "DF"}
		
		var htmlTest = AddHTMLToFeed(marker)

		expect(htmlTest).toBeDefined();
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

describe('loadAndUpdateMarkers', function(){
	it('shold blalba', function(){
		var data = [{"name": "Jeferson"}, {"instance_url": "http://mapas.cultura.gov.br/agente/1"}]
		var imageExtension = 'gif'

		spyOn(map, 'addLayer')
		loadAndUpdateMarkers(data, imageExtension)
		expect(map.addLayer).toHaveBeenCalled()
	});
});

describe('initialize_data_map', function() {
	it('Should initialize map data', function(){
		var test = {}
		var equal = initialize_data_map()
		expect(typeof test).toEqual(typeof equal)
	});
});

describe('updateFeed', function(){
	it('update feed with every markers ', function(){
		var recent_markers = []
        var marker = {"name": "Jeferson",
        			"marker_type": "agent",
        			"instance_url": "http://mapas.cultura.gov.br/agente/1",
        			"action_type": "test",
        			"action_time": "testagain",
        			"city": "Brasilia",
        			"state": "DF"}
        recent_markers.push(recent_markers)

        spyOn(window, 'create_feed_block')
        updateFeed(recent_markers)
        expect(window.create_feed_block).toHaveBeenCalled()
	});
});