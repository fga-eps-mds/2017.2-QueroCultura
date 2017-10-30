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
    var agentB = new Chart(ctx_temporal, {
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


function per_area_graphic(per_area_keys, per_area_values){
    var ctxArea = document.getElementById("bar-chart-area");
    var nameArea = JSON.parse(per_area_keys);
    var amountArea = JSON.parse(per_area_values);
    var agentB = new Chart(ctxArea, {
                            type: 'bar',
                            data: {
                                labels: nameArea,
                                datasets: [{
                                    label: 'Área de atuação',
                                    data: amountArea,
                                    backgroundColor: poolColors(amountArea.length)
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
                                       text: 'Quantidade de registros por área de atuação'
                               }
                            }
                        });
}

function grow_graphic(temporal_keys ,temporal_values){
        var ctx = document.getElementById("line-chart-time");
        var name_growth = JSON.parse(temporal_keys);
        var temp_growth = JSON.parse(temporal_values);
        var agentchart = new Chart(ctx, {
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
