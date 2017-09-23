function getSpace(){	

	var getTimeNow = new Date();
	    getTimeNow.setHours(getTimeNow.getHours() - 3, getTimeNow.getMinutes()-5);
	    getTimeNow = getTimeNow.toJSON();

	    console.log(getTimeNow);

	    $.getJSON(
	      'http://mapas.cultura.gov.br/api/agent/find',

	      {
	        '@select' : 'id, name, location',
	        '@or' : 1,
	        'createTimestamp' : "GT("+getTimeNow+")",
	        'updateTimestamp' : "GT("+getTimeNow+")"
	      },

	    function(response){ console.log(response);
	        console.log(response[2]);
	        
	        for(var i = 0; i < response.length; i++){
	        	make_marker(response[i]["location"]["latitude"], response[i]["location"]["longitude"], response[i]["name"]);
	    	}
	    });

}	    