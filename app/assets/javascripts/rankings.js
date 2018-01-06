$(document).ready(function(){

  $(".sidebar-item--authors_mean").click(function(event){
    event.preventDefault();

    if (!$(this).hasClass('sidebar-item--active')) {
      $('.sidebar-item').removeClass('sidebar-item--active');
      $(this).addClass("sidebar-item--active");

      $(".content-dashboard").each(function(){
        if (!$(this).hasClass('hidden')) {
          $(this).addClass('hidden')
          $(this).fadeOut();
        } else {
          $(this).removeClass('hidden');
        }
      });
    }
  });

  $(".sidebar-item--authors_max").click(function(event){
    event.preventDefault();

    if (!$(this).hasClass('sidebar-item--active')) {
      $('.sidebar-item').removeClass('sidebar-item--active');
      $(this).addClass("sidebar-item--active");

      $(".content-dashboard").each(function(){
        if (!$(this).hasClass('hidden')) {
          $(this).addClass('hidden')
          $(this).fadeOut();
        } else {
          $(this).removeClass('hidden');
        }
      });
    }
  });

});
