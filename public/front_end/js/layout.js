jQuery(function($){
  $('#Search-btn').click(function(){
    $(this).hide();
    $('#search-input').show();
  });
  var that = $(this);
  var mSearch = $("#m-search");
  $("#search-input").bind("change paste keyup", function(){
    var value = $(this).val();
    if (!value) {
      mSearch.html("");
      return;
    }; 
    mSearch.html('tr:not([data-index*="' + value.toLowerCase() + '"]) {display: none;}');
  });
});
