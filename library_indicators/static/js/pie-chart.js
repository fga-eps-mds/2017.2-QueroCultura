function pie_chart(){
  var ctx = document.getElementById('pie-chart-library').getContext('2d');
  var chart = new Chart(ctx, {
    // The type of chart we want to create
    type: 'pie',

    // The data for our dataset
    data: {
        labels: ["Pública", "Privada"],
        datasets: [{
            label: "My First dataset",
            data: [10, 10],
            backgroundColor: [
              'rgba(255, 51, 51,1)',
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
