$(document).ready(
  function() {
    $('.decrease').click(decreaseItems);
});

var decreaseItems = function (){
  debugger;
  var line_item_id = $(this).parent().parent().data('line-item-id');
  $.ajax('/line_items/' + line_item_id + '/decrease');
};
