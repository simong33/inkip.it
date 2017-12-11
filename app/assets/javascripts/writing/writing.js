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
  $save.html("En train de sauvegarder...");
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
