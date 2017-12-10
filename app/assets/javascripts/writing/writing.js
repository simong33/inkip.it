var editor = new MediumEditor('.editable', {
  toolbar: {
      /* These are the default options for the toolbar,
         if nothing is passed this is what is used */
      allowMultiParagraphSelection: true,
      buttons: ['bold', 'italic', 'underline', 'h2', 'h3', 'quote'],
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

var line = new ProgressBar.Line('#progress-bar-book', {
  strokeWidth: 4,
  text: {
    value: gon.wordcount,
  },
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

//setup before functions
var typingTimer ;
var doneTypingInterval = 2000 ;
var $form = $('#form') ;
var $save = $('.saving-status');

//on keyup, start the countdown
$form.on('keyup', function () {
  $save.removeClass("saving-status--saved");
  $save.html("En train de sauvegarder...");
  clearTimeout(typingTimer);
  typingTimer = setTimeout(doneTyping, doneTypingInterval);
});

//on keydown, clear the countdown
$form.on('keydown', function () {
  clearTimeout(typingTimer);
});

//user is "finished typing," do something
function doneTyping () {
  $form.submit();
  $save.addClass("saving-status--saved");
  $save.html("Enregistré !");
}
