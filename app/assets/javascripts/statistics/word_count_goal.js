var wordCountGoalChart = new Chart(ctxWordCountGoal, {
    type: 'doughnut',
    data: {
        labels: ['Mots écrits', 'Mots restants'],
        datasets : [{
          data: [gon.wordcount, gon.words_left],
          backgroundColor: [
          'rgba(255, 99, 132, 0.2)',
          'rgba(57, 92, 124, 0.2)'
          ],
        }]
    },
    options: {
        maintainAspectRatio: false,
    }
});
