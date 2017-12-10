var wordCountGoalChart = new Chart(ctxWordCountGoal, {
    type: 'doughnut',
    data: {
        labels: ['Mots écrits', 'Mots pas écrits'],
        datasets : [{
          data: [gon.wordcount, gon.words_left],
          backgroundColor: [
          'rgba(255, 99, 132, 0.2)',
          'rgba(188, 99, 132, 0.2)'
          ]
        }]
    },
    options: {
        maintainAspectRatio: false,
    }
});
