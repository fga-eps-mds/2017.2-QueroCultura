//Essa função é chamada assim que a página carrega
//afim de mostrar apenas o primeiro gráfico na tela.
$(document).ready(function() {
  var options_list = create_option_list();

  for (var i = 0; i < options_list.length; i++) {
    $(options_list[i]).hide();
  }

  $(options_list[0]).fadeIn(1700);
  $('.container-indicators').css({visibility:'visible'})
});

//Executa sempre que ocorre mudança na barra de seleção
//fazendo com que a opção clicada seja a aparecer na tela.
$("input[name='sc-1-1']").on('change',function() {
  var option_clicked = $("input[name='sc-1-1']:checked").val();
  var options_list = create_option_list();

  for (var i = 0; i < options_list.length; i++) {
        $(options_list[i]).hide();
  }

  $(option_clicked).fadeIn(1500);
});

//Esse método retorna os possíveis valores de seleção na barra
//de navegação da página
function create_option_list() {
  var options_list = [];
  $(":radio").each(function(){
    var current_option = $(this).val();
    options_list.push(current_option);
  });

  return options_list;
}
