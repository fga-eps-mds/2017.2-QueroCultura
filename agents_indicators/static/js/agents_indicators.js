$("#quantitativo_mensal").show();
$("#agentes_tipo").hide();
$("#agentes_area").hide();
$("#crescimento").hide();

//Aparece quantitativo_mensal
$("#quantitativo_mensal_button").click(function() {
  $("#quantitativo_mensal").show();
  $("#agentes_tipo").hide();
  $("#agentes_area").hide();
  $("#crescimento").hide();
});

//Aparece agentes_tipo
$("#agentes_tipo_button").click(function() {
  $("#quantitativo_mensal").hide();
  $("#agentes_tipo").show();
  $("#agentes_area").hide();
  $("#crescimento").hide();
});

//Aparece agentes_area
$("#agentes_area_button").click(function() {
  $("#quantitativo_mensal").hide();
  $("#agentes_tipo").hide();
  $("#agentes_area").show();
  $("#crescimento").hide();
});

//Aparece crescimento
$("#crescimento_button").click(function() {
  $("#quantitativo_mensal").hide();
  $("#agentes_tipo").hide();
  $("#agentes_area").hide();
  $("#crescimento").show();
});
