// Carousel indicators has been moved from the carousel-inner div
// so we have to fix the function set the active class to the current li.

$(document).ready(function(){
  $('.carousel').carousel({
    interval: 10000
  })

  $('#card').on('slide.bs.carousel', function () {
    $holder = $( ".carousel-indicators li.active" );
    $holder.next( "li" ).addClass("active");
    if($holder.is(':last-child'))
    {
        $holder.removeClass("active");
        $(".carousel-indicators li:first").addClass("active");
    }
    $holder.removeClass("active");
  });
});