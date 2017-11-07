
function createOptions(category, description){
    var options = {}
    options.title = {display: true,
                     text: description
    }

    switch (category) {
        case "pie":
            options.cutoutPercentage = 50
            options.animation = {animateScale: true}
            break;
        case "bar":
            options.scales = {yAxes: [{ticks: {beginAtZero:true}}]}
            options.legend = {display: true}
            break;
    }

    return options
}

function createDataSet(category,label,values){
    var dataset = [{
                    label: label,
                    data: values
                }]

    var primary_blue = 'rgba(17,90,163,1)';
    var secondary_blue = 'rgba(86, 170, 255,1)';

    switch (category) {
        case "line":
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
            break;
        case "pie":
            dataset[0].backgroundColor = [primary_blue,secondary_blue]
            break;
        case "bar":
            dataset[0].backgroundColor = primary_blue
            break;
    }

    return dataset
}

function createData(category, keys, values, label){
    return {labels: keys,
        datasets: createDataSet(category,label, values)
    }
}

function createChart(graphics_data){
    var data = {type: graphics_data.category,
        data: createData(graphics_data.category, graphics_data.keys, graphics_data.values, graphics_data.label),
        options: createOptions(graphics_data.category, graphics_data.description)
    }
    return new Chart(graphics_data.context, data);
}
