var ctxWordCounts = document.getElementById("wordCounts").getContext('2d');

var wordCountsChart = new Chart(ctxWordCounts, {
    type: 'bar',
    data: {
        labels: gon.dwc_dates,
        datasets: [{
            label: 'Mots écrits par jour',
            data: gon.dwc_values,
            backgroundColor: 'rgba(255, 99, 132, 0.2)',
            borderColor: 'rgba(255,99,132,1)',
            borderWidth: 1
        }, {
          label: 'Cumul du nombre de mots',
          data: gon.dwc_total_values,
          type: 'line'
        }]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:true
                }
            }],
            xAxes: [{
                            time: {
                                unit: 'day'
                            }
                        }]
        },
        maintainAspectRatio: false,
    }
});
