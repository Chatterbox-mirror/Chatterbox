jQuery(function($){
  $('#page1 , #page2, #page3').css('height' , $(window).height() + 'px');
  $('#more').click(function(){
    $('html , body').animate({scrollTop: $('#page2').offset().top} , 800);
  });
});
