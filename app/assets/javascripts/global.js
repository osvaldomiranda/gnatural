$(document).on("page:load ready", function(){
  $('select#per_page').on("change",function() {
    var new_val = $(this).val();
    var new_param = $(this).attr('name');
    var url = "?" + all_params(new_param, new_val);
    window.location = url;
  });

  $('select[id^="filter_"]').on("change",function() {
    var new_val = $(this).val();
    var new_param = ($(this).attr("id")).replace("filter_", "");
    var url = "?" + all_params(new_param, new_val);
    window.location = url;
  });

});