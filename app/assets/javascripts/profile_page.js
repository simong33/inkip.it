$(document).ready(function(){
  if ($('#progress-bar-profile').length) {
    var bar = new ProgressBar.Line('#progress-bar-profile', {
      strokeWidth: 2,
      color: "#FFF",
      trailColor: "#eee",
      trailWidth: 1,
      from: {color: '#6C5B7B'},
      to: {color: '#355C7D'},
      duration: 1400,
      easing: 'easeInOut',
      step: (state, bar) => {
        bar.path.setAttribute('stroke', state.color);
      }
    });
    bar.animate(gon.wordcount_ratio)
  }
});
