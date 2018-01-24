$(document).ready(function(){
    $("#add-book-btn").click(function(){
      $("#newBook").modal();
    });

    $(".alert" ).fadeOut(6000);

    $(".sidebar-item--your-published-books").click(function(event){
      event.preventDefault();

      if (!$(this).hasClass('sidebar-item--active')) {
        $('.sidebar-item').removeClass('sidebar-item--active');
        $(this).addClass("sidebar-item--active");

        $(".content-dashboard").each(function(){
          $(this).addClass('hidden');
          $('#your-published-books').removeClass('hidden');
        });
      }
    });

    $(".sidebar-item--your-books").click(function(event){
      event.preventDefault();

      if (!$(this).hasClass('sidebar-item--active')) {
        $('.sidebar-item').removeClass('sidebar-item--active');
        $(this).addClass("sidebar-item--active");

        $(".content-dashboard").each(function(){
          $(this).addClass('hidden');
          $('#your-books').removeClass('hidden');
        });
      }
    });
});
