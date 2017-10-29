$("#quantitativo_mensal").show();
$("#events_type").hide();
$("#events_language").hide();
$("#crescimento").hide();

//Aparece quantitativo_mensal
$("#quantitativo_mensal_button" ).click(function() {
  $("#quantitativo_mensal").show();
  $("#events_type").hide();
  $("#events_language").hide();
  $("#crescimento").hide();
});

//Aparece agentes_tipo
$("#agentes_tipo_button" ).click(function() {
  $("#quantitativo_mensal").hide();
  $("#events_type").show();
  $("#events_language").hide();
  $("#crescimento").hide();
});

//Aparece agentes_area
$("#agentes_area_button" ).click(function() {
  $("#quantitativo_mensal").hide();
  $("#events_type").hide();
  $("#events_language").show();
  $("#crescimento").hide();
});

//Aparece crescimento
$("#crescimento_button" ).click(function() {
  $("#quantitativo_mensal").hide();
  $("#events_type").hide();
  $("#events_language").hide();
  $("#crescimento").show();
});
