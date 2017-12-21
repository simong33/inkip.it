$(document).ready(function(){
  window.sr = ScrollReveal({ reset: true });
  sr.reveal('.value-proposition-block', {
    duration: 1000,
    origin: 'top',
    reset: false,
  });
  sr.reveal('.screenshot', {
    duration: 1000,
    origin: 'top',
    reset: false,
  });

  // TYPER
  // https://github.com/qodesmith/typer

  var words = [
    "histoires",
    "épopées",
    "intrigues",
    "aventures"
  ] ;
  typer('#typer', {min: 50, max: 350})
    .line(words[0])
    .back("all")
    .continue(words[1])
    .back("all")
    .continue(words[2])
    .back("all")
    .continue(words[3]);
});
