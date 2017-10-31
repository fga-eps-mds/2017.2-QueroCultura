function public_private_chart(amount_public_libraries, amount_private_libraries){
    graphics_data = {keys: ["Pública", "Privada"],
                     values: [amount_public_libraries, amount_private_libraries],
                     category: "pie"
    }
    graphics_data.label = "Points"
    graphics_data.context = document.getElementById('pie-chart-library').getContext('2d')
    graphics_data.description = 'Porcentagem de bibliotecas públicas e privadas'

    createChart(graphics_data)
}

function bar_chart(indicators, chartId, label, description){
    indicators = convertIndicators(indicators)
    graphics_data = {category: "bar",
                     keys: indicators.keys,
                     values: indicators.values,
                     label: label,
                     context:document.getElementById(chartId),
                     description:description
    }

    createChart(graphics_data)
}

function line_chart(indicators, chartId, label, description){
    indicators = convertIndicators(indicators)
    graphics_data = {category: "line",
                     keys: indicators.keys,
                     values: indicators.values,
                     label: label,
                     context:document.getElementById(chartId),
                     description:description
    }

    createChart(graphics_data)
}

function convertIndicators(indicators){
    var keys = [];
    var values = [];

    jQuery.each(indicators, function(key, value){
      keys.push(key);
      values.push(value);
    });

    var newIndicators = {keys: keys, values:values}
    return newIndicators
}
