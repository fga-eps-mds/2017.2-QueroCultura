function createDefaultData(category, data_keys, data_values){
    var graphics_data = {category: category,
        keys: JSON.parse(data_keys),
        values: JSON.parse(data_values)
    }
    return graphics_data
}


function temporal_bar_graphic(data_keys ,data_values){
    var graphics_data = createDefaultData("bar", data_keys, data_values)

    graphics_data.label = 'Quantidades de registros por mês'
    graphics_data.context = document.getElementById("bar-chart-temporal")
    graphics_data.description = 'Quantidades de Registros a cada mês'

    createChart(graphics_data)
}


function type_bar_graphic(data_keys ,data_values){
    var graphics_data = createDefaultData("bar", data_keys, data_values)

    graphics_data.label = 'Quantidades de registros por tipo'
    graphics_data.context = document.getElementById("bar-chart-type")
    graphics_data.description = 'Quantidades de Registros por tipo'

    createChart(graphics_data)
}


function online_pie_graphic(data_keys ,data_values){
    var graphics_data = createDefaultData("pie", data_keys, data_values)

    graphics_data.label = 'Quantidade de projetos que aceitam inscrições online.'
    graphics_data.context = document.getElementById("pie-chart-online").getContext('2d')
    graphics_data.description = 'Quantidades de Registros que aceitam inscrições online.'

    createChart(graphics_data)
}


function growth_line_graphic(data_keys ,data_values){
    var graphics_data = createDefaultData("line", data_keys, data_values)

    graphics_data.label = 'Quantidade de projetos ao longo de sua existência.'
    graphics_data.context = document.getElementById("line-chart-growth")
    graphics_data.description = 'Este gráfico ilustra o crescimento da plataforma em relação ao total de registros de projetos ao longo de sua existência.'

    createChart(graphics_data)
}
