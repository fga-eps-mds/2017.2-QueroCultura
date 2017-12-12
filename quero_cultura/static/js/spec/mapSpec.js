describe('GetImageByType', function () {
	it('should return a markerAgent image', function () {
		image = "static/images/markerAgent.png";
		type = "agent";
    });

	it('should return a markerSpace image', function () {
		image = "static/images/markerSpace.png"
		type = "space";
    });

	it('should return a markerProject image', function () {
		image = "static/images/markerProject.png";
		type = "project";
    });

	it('should return a markerEvent image', function () {
		image = "static/images/markerEvent.png";
		type = "event";
	});

	afterEach(function(){
		imageTest = GetImageByType(type);
		expect(imageTest).toEqual(image);
	});
});

describe('AddHTMLToFeed', function () {
	it('should return html', function () {
        var marker = {"name": "Jeferson",
        			"marker_type": "agent",
        			"instance_url": "http://mapas.cultura.gov.br/agente/1",
        			"action_type": "criação",
        			"action_time": "2017-12-11 21:32:01.289113",
        			"city": "Brasilia",
        			"state": "DF",
        			"location": {"latitude": 0, "longitude": 0}}
		
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
	it('should update feed with every markers ', function(){
		var recent_markers = []
        var marker = {"name": "Jeferson",
        			"marker_type": "agent",
        			"instance_url": "http://mapas.cultura.gov.br/agente/1",
        			"action_type": "test",
        			"action_time": "testagainagainagainagain",
        			"city": "Brasilia",
        			"state": "DF",
        			"location": {"latitude": 0, "longitude": 0}}
        recent_markers.push(marker)

        spyOn(window, 'create_feed_block')
        updateFeed(recent_markers)
        expect(window.create_feed_block).toHaveBeenCalled()
	});
	
	it('should change city and state to blank', function(){
		var recent_markers = []
        var marker = {"name": "Jeferson",
        			"marker_type": "agent",
        			"instance_url": "http://mapas.cultura.gov.br/agente/1",
        			"action_type": "test",
        			"action_time": "testagainagainagainagain",
        			"location": {"latitude": 0, "longitude": 0}}
        recent_markers.push(marker)

        spyOn(window, 'create_feed_block')
        updateFeed(recent_markers)
        expect(recent_markers[0]["city"]).toEqual('')
        expect(recent_markers[0]["state"]).toEqual('')
	});
});

describe('fitBounds', function(){
	it('should focus on marker selected', function(){
		var latitude = 0
		var longitude = 0

		spyOn(map, 'fitBounds')
		focusOnMarker(latitude, longitude)
		expect(map.fitBounds).toHaveBeenCalled()
	})
});

describe('formatName', function(){
	it('should format name blank', function(){
		var name = ''
		teste = formatName(name)
		expect(teste).toEqual('--------')
	});
});