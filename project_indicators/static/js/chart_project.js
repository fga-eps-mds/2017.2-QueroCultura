function temporal_line_graphic(data_keys ,data_values){
    var graphics_data = createDefaultData("bar", data_keys, data_values)

    graphics_data.label = 'Quantidades de registros por mês'
    graphics_data.context = document.getElementById("line-chart-temporal")
    graphics_data.description = 'Quantidades de Registros a cada mês'

    createChart(graphics_data)
}

function createDefaultData(category, data_keys, data_values){
    var graphics_data = {category: category,
                         keys: JSON.parse(data_keys),
                         values: JSON.parse(data_values)
        }
        return graphics_data
}
