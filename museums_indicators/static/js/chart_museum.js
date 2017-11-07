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