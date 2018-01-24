var editor = new MediumEditor('.editable', {
  toolbar: {
      /* These are the default options for the toolbar,
         if nothing is passed this is what is used */
      allowMultiParagraphSelection: true,
      buttons: ['bold', 'italic', 'underline'],
      diffLeft: 0,
      diffTop: -10,
      firstButtonClass: 'medium-editor-button-first',
      lastButtonClass: 'medium-editor-button-last',
      relativeContainer: null,
      standardizeSelectionStart: false,
      static: false,
      /* options which only apply when static is true */
      align: 'center',
      sticky: false,
      updateOnEmptySelection: false
  },
  placeholder: {
      /* This example includes the default options for placeholder,
         if nothing is passed this is what it used */
      text: 'Il était une fois...',
      hideOnClick: true
  }
});


if ($('#progress-bar-book').length) {
  var line = new ProgressBar.Line('#progress-bar-book', {
    strokeWidth: 4,
    easing: 'easeIn',
  });
  $(document).ready(function(){

    line.animate(gon.word_goal_ratio, {
      duration: 800,
      from: { color: '#eee' },
      to: { color: '#000' },
    }, function() {
    });
  });
}



// AUTO-SAVE WHEN USER STOP WRITING

//setup before functions
var typingTimer ;
var doneTypingInterval = 2000 ;
var $form = $('#form') ;
var $save = $('.saving-status');

//on keyup, start the countdown
$form.on('keyup', function () {
  $save.removeClass("saving-status--saved");
  $save.html("Sauvegarde...");
  clearTimeout(typingTimer);
  typingTimer = setTimeout(doneTyping, doneTypingInterval);
});

//on keydown, clear the countdown
$form.on('keydown', function () {
  clearTimeout(typingTimer);
});

// user is "finished typing," do something
function doneTyping () {
  $form.submit();
  $save.addClass("saving-status--saved");
  $save.html("Enregistré !");
  if ($('#progress-bar-book').length) {
    $.get(gon.fetch_refresh_wordcount_url,function(data){
         console.log(data)
         line.animate(data);
      });
  }
}

// INKS ANIMATION

// https://codepen.io/ohansemmanuel/pen/dVdvJQ

var inkdrop = document.getElementById('inkdrop')
var inkIcon = document.getElementById('inkdrop-icon')
var inkCount = document.getElementById('ink-count')
var inkTotalCount = document.getElementById('ink-total-count')
var tlDuration = 300
var numberOfClicks = 0
var inkHold;

inkTotalCount.innerHTML = gon.inks

var triangleBurst = new mojs.Burst({
  parent: inkdrop,
  radius: {50:95},
  count: 5,
  angle: 30,
  children: {
    shape: 'polygon',
    radius: {6: 0},
    scale: 1,
    stroke: 'rgba(211,84,0 ,0.5)',
    strokeWidth: 2,
    angle: 210,
    delay: 30,
    speed: 0.2,
    easing: mojs.easing.bezier(0.1, 1, 0.3 ,1),
    duration: tlDuration
  }
})

var circleBurst = new mojs.Burst({
  parent: inkdrop,
  radius: {50:75},
  angle: 25,
  duration: tlDuration,
  children: {
    shape: 'circle',
    fill: 'rgba(149,165,166 ,0.5)',
    delay: 30,
    speed: 0.2,
    radius: {3: 0},
    easing: mojs.easing.bezier(0.1, 1, 0.3, 1),
  }
})

var countAnimation = new mojs.Html({
  el: '#ink-count',
  isShowStart: false,
  isShowEnd: true,
  y: {0: -30},
  opacity: {0:1},
  duration: tlDuration
}).then({
  opacity: {1:0},
  y: -80,
  delay: tlDuration/2
})

var countTotalAnimation = new mojs.Html({
  el: '#ink-total-count',
  isShowStart: true,
  isShowEnd: true,
  opacity: {1:1},
  delay: 3*(tlDuration)/2,
  duration: tlDuration,
})

var scaleButton = new mojs.Html({
  el: '#inkdrop',
  duration: tlDuration,
  scale: {1.3: 1},
  easing: mojs.easing.out
})

inkdrop.style.transform = "scale(1, 1)"

var animationTimeline = new mojs.Timeline()
animationTimeline.add([
  triangleBurst,
  circleBurst,
  countAnimation,
  countTotalAnimation,
  scaleButton
])

inkdrop.addEventListener('click', function() {
   repeatInking();
})

inkdrop.addEventListener('mousedown', function() {
  inkHold = setInterval(function() {
  repeatInking();
  }, 400);
})

inkdrop.addEventListener('mouseup', function() {
 clearInterval(inkHold);
})

function repeatInking() {
  animationTimeline.replay()
  inkIcon.classList.add('checked')
}
