
function per_age_range_graphic(per_age_range_keys, per_age_range_values){
    var ctx_age_range = document.getElementById("bar-chart-events");
    var name_age_range = JSON.parse(per_age_range_keys);
    var value_age_range = JSON.parse(per_age_range_values);
    var event_age_range = new Chart(ctx_age_range, {
        type: 'bar',
        data: {
            labels: name_age_range,
            datasets: [{
                label: 'Faixa Etaria',
                data: value_age_range,
                backgroundColor: 'rgba(17,90,163,1)'
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {beginAtZero:true}
                }]
            },
            legend: {display: true},
            title: {display: true,
                text: 'Quantidade de registros por faixa etaria'
            }
        }
    });
}
