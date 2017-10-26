
var ctx = document.getElementById("productsChart");
	var names = JSON.parse('{{ names|safe }}');
	var prices = JSON.parse('{{ prices|safe }}');
	var productsChart = new Chart(ctx, {
	    type: 'line',
	    data: {
	        labels: names,
	        datasets: [{
	            label: 'Quantidades de Registros por Mês ao Longo do Ano',
	            data: prices,
	            borderWidth: 2.5,
	            borderColor: 'rgba(77,166,253,0.85)',
	            backgroundColor: 'transparent',
              
	        }]
	    },
	    
	});