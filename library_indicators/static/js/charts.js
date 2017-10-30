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

function public_private_chart(amount_public_libraries, amount_private_libraries){
  var ctx = document.getElementById('pie-chart-library').getContext('2d');
  var chart = new Chart(ctx, {
    // The type of chart we want to create
    type: 'pie',

    // The data for our dataset
    data: {
        labels: ["Pública", "Privada"],
        datasets: [{
            label: "Points",
            data: [amount_public_libraries, amount_private_libraries],
            backgroundColor: [
              'rgba(255, 51, 51, 1)',
              'rgba(153, 255, 51, 1)',
            ]
        }]
    },
    // Configuration options go here
    options: {
      cutoutPercentage: 50,
      animation:{
        animateScale: true,
      },
      title: {
        display: true,
        text: 'Porcentagem de bibliotecas públicas e privadas'
      }
    }
  });
}

function per_area_chart(ocupation_area_total){
  var ctxArea = document.getElementById("bar-chart-area");
  console.log(ocupation_area_total);
  var nameArea = [];
  var amountArea = [];
  jQuery.each(ocupation_area_total, function(key, value){
    nameArea.push(key);
    amountArea.push(value);
  });


  console.log(ocupation_area_total);
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
