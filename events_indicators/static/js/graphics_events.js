function poolColors(a) {
    var pool = [];
    for(i=0;i<a;i++){
        pool.push(dynamicColors());
    }
    return pool;
}

function dynamicColors() {
    var r = Math.floor(Math.random() * 255);
    var g = Math.floor(Math.random() * 255);
    var b = Math.floor(Math.random() * 255);
    return "rgb(" + r + "," + g + "," + b + ")";
}

function temporal_graphic(keys,data){
    var ctx_temporal = document.getElementById("bar-chart-month");

    var name_temporal = JSON.parse(keys);
    var value_temporal = JSON.parse(data);
    var chart_temporal = new Chart(ctx_temporal, {
                            type: 'bar',
                            data: {
                                labels: name_temporal,
                                datasets: [{
                                    label: 'Cadastros no mês',
                                    data: value_temporal,
                                    backgroundColor: poolColors(value_temporal.length)
                                }]
                            },
                            options: {
                                scales: {yAxes: [{ticks: {beginAtZero:true}}]},
                                legend: {display: false},
                                title: {display: true,
                                        text: 'Quantidade de registros cadastrados no mês'
                                        }
                            }
                    });
}


function per_language_graphic(per_language_keys, per_language_values){
    var ctxLanguage = document.getElementById("bar-chart-language");
    var nameLanguage = JSON.parse(per_language_keys);
    var amountLanguage = JSON.parse(per_language_values);
    var event_language = new Chart(ctxLanguage, {
                            type: 'bar',
                            data: {
                                labels: nameLanguage,
                                datasets: [{
                                    label: 'Linguagem',
                                    data: amountLanguage,
                                    backgroundColor: poolColors(amountLanguage.length)
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
                                       text: 'Quantidade de registros por linguagem'
                               }
                            }
                        });
}

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
                                      backgroundColor: poolColors(value_age_range.length)
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

function per_grow_graphic(temporal_keys ,temporal_values){
        var ctx = document.getElementById("line-chart-time");
        var name_growth = JSON.parse(temporal_keys);
        var temp_growth = JSON.parse(temporal_values);
        var eventchart = new Chart(ctx, {
                                type: 'line',
                                data: {labels: name_growth,
                                       datasets: [{
                                                    label: 'Quantidades total de registros no momento',
                                                    data: temp_growth,
                                                    fill: false,
                                                    borderWidth: 2.5,
                                                    borderColor: 'rgba(77,166,253,0.85)',
                                                    backgroundColor: 'transparent',
                            	                    bordeCapStyle: 'butt',
                        	                        borderDash: [],
                                	                borderJoinStyle: 'miter',
                                	                pointBorderColor: "rgba(75,192,192,1",
                                	                pointBackgroundColor: "fff",
                            	                    pointBorderWidth: 3,
                                	                pointHoverRadius: 5,
                            	                    pointHoverBackgroundColor: "rgba(75,192,192,1)",
                                	                pointHoverBorderColor: "rgba(220,220,220,1)",
                                	                pointHoverBorderWidth: 2,
                                	                pointRadius: 1,
                                	                pointHitRadius: 10
                                                }]
                                        },
                                options: {title: {display: true,
                                                  text: 'Quantidades de Registros ao longo do tempo'
                                                }
                                        }
                        });
}
