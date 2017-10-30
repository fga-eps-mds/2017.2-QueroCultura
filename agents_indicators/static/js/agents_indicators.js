var options_list = ["#quantitativo_mensal", "#agentes_tipo", "#agentes_area", "#crescimento"]

$(document).ready(function() {
  for (var i = 0; i < options_list.length; i++) {
    $(options_list[i]).hide();
  }
  $(options_list[0]).show('medium', function() {});
  $('.container-indicators').css({visibility:'visible'})
});

$("input[name='sc-1-1']").on('change',function() {
  var option_clicked = $("input[name='sc-1-1']:checked").val();
  for (var i = 0; i < options_list.length; i++) {
        $(options_list[i]).hide();
  }
  $(option_clicked).show('medium', function() {});
});
