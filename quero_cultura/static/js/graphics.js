function temporal_graphic(temporal_keys,temporal_data){
    var keys = JSON.parse(temporal_keys);
    var values = JSON.parse(temporal_data);
    var context = document.getElementById("bar-chart-month");

    var label = 'Cadastros no Mês'
    var description = 'Quantidade de registros cadastrados no mês'
    var category = 'bar'
    createChart(category, context, keys, values, label, description)
}


function per_area_graphic(per_area_keys, per_area_values){
    var keys = JSON.parse(per_area_keys);
    var values = JSON.parse(per_area_values);
    var context = document.getElementById("bar-chart-area");

    var label = 'Área de atuação'
    var description = 'Quantidade de registros por área de atuação'
    var category = 'bar'
    createChart(category, context, keys, values, label, description)
}

function growth_graphic(temporal_keys ,temporal_values){
    var keys = JSON.parse(temporal_keys);
    var values = JSON.parse(temporal_values);
    var context = document.getElementById("line-chart-time");

    var label = 'Quantidades total de registros no momento'
    var description = 'Quantidades de Registros ao longo do tempo'
    var category = 'line'
    createChart(category, context, keys, values, label, description)
}

function per_type_graphic(per_type_keys, per_type_values){
    var keys = JSON.parse(per_type_keys);
    var values = JSON.parse(per_type_values);
    var context = document.getElementById("pie-chart-agents");

    var label = "Points"
    var description = 'Porcentagem de agentes individuais e coletivos'
    var category = "pie"
    createChart(category, context, keys, values, label, description)
}
