$(document).ready(function(){
  $("#add-chapter-btn").click(function(){
    $("#newChapter").modal();
  });
  $("#add-character-btn").click(function(){
    $("#newCharacter").modal();
  });
  $("#add-place-btn").click(function(){
    $("#newPlace").modal();
  });

  var loader = $("#loader-container") ;

  $('.sidebar-item--community').click(function() {
    $("#all-published-books").html(loader);
    loader.removeClass("hidden");
  });

  $( document ).ajaxStart(function() {

  });
});
