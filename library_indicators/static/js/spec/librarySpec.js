describe('public_private_chart', function(){
    it('should creat public and private chart', function(){
        var stringChart = '<div><canvas style="display:none" id="pie-chart-library"></canvas></div>'

        $("body").append(stringChart)

        graphics_data = {keys: ["Pública", "Privada"],
                         values: [10, 10],
                         category: "pie"
        }
        graphics_data.label = "Points"
        graphics_data.context = document.getElementById('pie-chart-library').getContext('2d')
        graphics_data.description = 'Porcentagem de bibliotecas públicas e privadas'

        spyOn(window, 'createChart')

        public_private_chart(10, 10)

        expect(window.createChart).toHaveBeenCalledWith(graphics_data)
    });
});

describe('bar_chart', function(){
    it('should create bar chart', function(){
        var stringChart = '<div><canvas style="display:none" id="pie-chart-library"></canvas></div>'
        $("body").append(stringChart)

        indicators = []
        indicators = convertIndicators(indicators)
        graphics_data = {category: "bar",
                         keys: indicators.keys,
                         values: indicators.values,
                         label: 'Tipo de esfera',
                         context:document.getElementById("bar-chart-sphere"),
                         description: 'Quantidade de registros por tipo de esfera'
        }

        spyOn(window, 'createChart')

        bar_chart(indicators, "bar-chart-sphere", 'Tipo de esfera', 'Quantidade de registros por tipo de esfera')

        expect(window.createChart).toHaveBeenCalledWith(graphics_data)
    });
});
