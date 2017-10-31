function public_private_chart(amount_public_libraries, amount_private_libraries){
    var keys = ["Pública", "Privada"]
    var values = [amount_public_libraries, amount_private_libraries]
    var context = document.getElementById('pie-chart-library').getContext('2d');

    var label = "Points"
    var description = 'Porcentagem de bibliotecas públicas e privadas'
    var category = "pie"

    createChart(category, context, keys, values, label, description)
}

function bar_chart(indicators, chartId, label, description){
    indicators = convertIndicators(indicators)
    var keys = indicators.keys;
    var values = indicators.values;

    var context = document.getElementById(chartId);

    var category = 'bar'
    createChart(category, context, keys, values, label, description)
}

function line_chart(indicators, chartId, label, description){
    indicators = convertIndicators(indicators)
    var keys = indicators.keys;
    var values = indicators.values;

    var context = document.getElementById(chartId);

    var category = "line"
    createChart(category, context, keys, values, label, description)
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
