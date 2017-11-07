function createDefaultData(category, data_keys, data_values){
    var graphics_data = {category: category,
        keys: JSON.parse(data_keys),
        values: JSON.parse(data_values)
    }
    return graphics_data
}

function growth_line_graphic(data_keys ,data_values){
    var graphics_data = createDefaultData("line", data_keys, data_values)

    graphics_data.label = 'Quantidade de projetos ao longo de sua existência.'
    graphics_data.context = document.getElementById("line-chart-growth")
    graphics_data.description = 'Este gráfico ilustra o crescimento da plataforma em relação ao total de registros de projetos ao longo de sua existência.'

    createChart(graphics_data)
}

function type_bar_graphic(data_keys ,data_values){
    var graphics_data = createDefaultData("bar", data_keys, data_values)

    graphics_data.label = 'Quantidades de registros por tipo'
    graphics_data.context = document.getElementById("bar-chart-type")
    graphics_data.description = 'Quantidades de Registros por tipo'

    createChart(graphics_data)
}

function thematic_bar_graphic(data_keys ,data_values){
    var graphics_data = createDefaultData("bar", data_keys, data_values)

    graphics_data.label = 'Quantidades de registros por tipo'
    graphics_data.context = document.getElementById("bar-chart-thematic")
    graphics_data.description = 'Quantidades de Registros por tipo'

    createChart(graphics_data)
}


function archive_pie_graphic(data_keys, data_values){
    var graphics_data = createDefaultData("pie", data_keys, data_values)

    graphics_data.label = "Points"
    graphics_data.context = document.getElementById("pie-chart-archive").getContext('2d')
    graphics_data.description = 'Porcentagem de agentes individuais e coletivos'

    createChart(graphics_data)
}

function guided_pie_graphic(data_keys, data_values){
    var graphics_data = createDefaultData("pie", data_keys, data_values)

    graphics_data.label = "Points"
    graphics_data.context = document.getElementById("pie-chart-guided").getContext('2d')
    graphics_data.description = 'Porcentagem de agentes individuais e coletivos'

    createChart(graphics_data)
}

function sphere_pie_graphic(data_keys, data_values){
    var graphics_data = createDefaultData("pie", data_keys, data_values)

    graphics_data.label = "Points"
    graphics_data.context = document.getElementById("pie-chart-sphere").getContext('2d')
    graphics_data.description = 'Porcentagem de agentes individuais e coletivos'

    createChart(graphics_data)
}