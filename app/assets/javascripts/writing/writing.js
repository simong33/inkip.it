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
    value: '2356/10000',
  },
  easing: 'easeIn',
});

$(document).ready(function(){

  line.animate(0.8, {
    duration: 800
  }, function() {
    console.log('Finished!');
  });

  // $(".content-writing-text").mention({
  //   users: [{
  //     name: 'Lindsay Made',
  //     username: 'LindsayM',
  //     image: 'http://placekitten.com/25/25'
  //   }, {
  //     name: 'Rob Dyrdek',
  //     username: 'robdyrdek',
  //     image: 'http://placekitten.com/25/24'
  //   }, {
  //     name: 'Rick Bahner',
  //     username: 'RickyBahner',
  //     image: 'http://placekitten.com/25/23'
  //   }, {
  //     name: 'Jacob Kelley',
  //     username: 'jakiestfu',
  //     image: 'http://placekitten.com/25/22'
  //   }, {
  //     name: 'John Doe',
  //     username: 'HackMurphy',
  //     image: 'http://placekitten.com/25/21'
  //   }, {
  //     name: 'Charlie Edmiston',
  //     username: 'charlie',
  //     image: 'http://placekitten.com/25/20'
  //   }, {
  //     name: 'Andrea Montoya',
  //     username: 'andream',
  //     image: 'http://placekitten.com/24/20'
  //   }, {
  //     name: 'Jenna Talbert',
  //     username: 'calisunshine',
  //     image: 'http://placekitten.com/23/20'
  //   }, {
  //     name: 'Street League',
  //     username: 'streetleague',
  //     image: 'http://placekitten.com/22/20'
  //   }, {
  //     name: 'Loud Mouth Burrito',
  //     username: 'Loudmouthfoods',
  //     image: 'http://placekitten.com/21/20'
  //   }]
  // });
});
