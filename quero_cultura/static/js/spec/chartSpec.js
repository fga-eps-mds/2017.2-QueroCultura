describe('createOptions', function(){
    it('should create options for pie', function(){
        var options = {}
        options.title = {display: true,
                         text: 'description',
        }
        options.cutoutPercentage = 50
        options.animation = {animateScale: true}

        var test = createOptions('pie', 'description')

        expect(test).toEqual(options)
    });

    it('should create options for bar', function(){
        var options = {}
        options.title = {display: true,
                         text: 'description',
        }
        options.scales = {yAxes: [{ticks: {beginAtZero:true}}]}
        options.legend = {display: true}

        var test = createOptions('bar', 'description')

        expect(test).toEqual(options)
    });
})

describe('createDataSet', function(){
    it('should create line dataset', function(){
        label = []
        values = []
        var dataset = [{
                        label: [],
                        data: []
                    }]
        dataset[0].backgroundColor = "transparent"
        dataset[0].fill = false
        dataset[0].borderWidth = 2.5
        dataset[0].borderColor = 'rgba(77,166,253,0.85)'
        dataset[0].borderCapStyle = 'butt'
        dataset[0].borderDash = []
        dataset[0].borderJoinStyle = 'miter'
        dataset[0].pointRadius = 1
        dataset[0].pointHitRadius = 10
        dataset[0].pointBackgroundColor = "fff"
        dataset[0].pointBorderWidth = 3
        dataset[0].pointHoverRadius = 5
        dataset[0].pointHoverBorderWidth = 2
        dataset[0].pointHoverBackgroundColor = "rgba(75,192,192,1)"
        dataset[0].pointHoverBorderColor = "rgba(220,220,220,1)"
        dataset[0].pointBorderColor = "rgba(75,192,192,1)"

        var testLine = createDataSet('line', label, values)

        expect(dataset).toEqual(testLine)
    });

    it('should create pie dataset', function(){
        label = []
        values = []
        var dataset1 = [{
                        label: [],
                        data: []
                    }]
        dataset1[0].backgroundColor = ['rgba(255, 51, 51,1)','rgba(153, 255, 51, 1)']


        var testPie = createDataSet('pie', label, values)

        expect(dataset1).toEqual(testPie)
    });

    it('should create bar dataset', function(){
        label = []
        values = []
        var dataset = [{
                        label: [],
                        data: []
                    }]
        dataset[0].backgroundColor = poolColors(values.length)

        var testBar = createDataSet('bar', label, values)

        expect(dataset).toEqual(testBar)
    })
});

describe('createData', function(){
    it('should create data', function(){
        category = 'pie'
        keys = []
        values = []
        label = 'test'
        data = createData(category, keys, values, label)

        expect(data).toEqual({labels: keys,
            datasets: createDataSet(category,label, values)})
    });
})

describe('createChart', function(){
    beforeEach(function(){
        graphics_data = {keys: ["Pública", "Privada"],
                         values: [10, 10],
                         category: "pie"
        }
        graphics_data.label = "Points"
        graphics_data.context = document.getElementById('pie-chart-library').getContext('2d')
        graphics_data.description = 'Porcentagem de bibliotecas públicas e privadas'
	});

    it('should create chart', function(){

        spyOn(window, 'Chart')

        createChart(graphics_data)

        expect(window.Chart).toHaveBeenCalled()

    });

    it('should create options', function(){
        spyOn(window, 'createOptions')
        createChart(graphics_data)
        expect(window.createOptions).toHaveBeenCalled()
    });
});
