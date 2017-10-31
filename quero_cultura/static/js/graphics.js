function createDefaultData(category, data_keys, data_values){
    var graphics_data = {category: category,
                         keys: JSON.parse(data_keys),
                         values: JSON.parse(data_values)
        }
        return graphics_data
}

function per_month_bar_graphic(data_keys, data_values){
    var graphics_data = createDefaultData("bar", data_keys, data_values)

    graphics_data.label = 'Cadastros no Mês'
    graphics_data.context = document.getElementById("bar-chart-month")
    graphics_data.description = 'Quantidade de registros cadastrados no mês'

    createChart(graphics_data)
}


function per_area_bar_graphic(data_keys, data_values){
    var graphics_data = createDefaultData("bar", data_keys, data_values)

    graphics_data.label = 'Área de atuação'
    graphics_data.context = document.getElementById("bar-chart-area")
    graphics_data.description = 'Quantidade de registros por área de atuação'

    createChart(graphics_data)
}

function growth_line_graphic(data_keys ,data_values){
    var graphics_data = createDefaultData("line", data_keys, data_values)

    graphics_data.label = 'Quantidades total de registros no momento'
    graphics_data.context = document.getElementById("line-chart-time")
    graphics_data.description = 'Quantidades de Registros ao longo do tempo'

    createChart(graphics_data)
}


function per_type_pie_graphic(data_keys, data_values){
    var graphics_data = createDefaultData("pie", data_keys, data_values)

    graphics_data.label = "Points"
    graphics_data.context = document.getElementById("pie-chart-agents")
    graphics_data.description = 'Porcentagem de agentes individuais e coletivos'

    createChart(graphics_data)
}
