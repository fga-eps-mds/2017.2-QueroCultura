//Create web site tour
function startIntro(pageDef){


  var intro = introJs();

    intro.setOption("nextLabel", '<img src="static/images/arrow.png" height="15px" alt="" />')

    intro.setOption("prevLabel", '<img src="static/images/invert_arrow.png" height="15px" alt="" />')
    intro.setOption("skipLabel", '<img src="static/images/x_button.png" height="15px" alt="" />')
    intro.setOption("doneLabel", '<img src="static/images/x_button.png" height="15px" alt="" />')
    .setOption("showStepNumbers", false)

    switch (pageDef) {
      case 1:
      intro.setOptions({
       steps: [

           {
                intro: "<h2>Bem vindo</h2>O QueroCultura é uma plataforma Web de visualização de dados. Vamos começar o tour !",

           },

           {

                intro: '<h2>Mapa</h2>No mapa você poderá ver as últimas atualizações da plataforma <a target="_blank" href="http://mapas.cultura.gov.br">Mapas Culturais</a>.'
            },

            {

               intro: '<h2>Zoom</h2>Para uma melhor intereção com o mapa use a tecla de zoom para ver os locais de interesse.',
               element: ".leaflet-control-zoom"

            },


            {

               intro: '<h2>Filtro</h2>Nos filtos você pode escolher quais marcadores gostaria de ver e escolher a cor do mapa',
               element: ".leaflet-control-layers-toggle"
            },

            {

               intro: '<h2>Marcadores</h2>Os marcadores mostram novos cadastros e atualizações da plataforma <a target="_blank" href="http://mapas.cultura.gov.br">Mapas Culturais</a>, para ver um marcador clique .',
            },

            {

               intro: '<h2>Tipos de marcadores</h2> Os marcadores de agentes: <img src="static/images/markerAgent.png" height="35" /><br> Marcadores de projetos: <img src="static/images/markerProject.png" height="35px" alt="" /><br> Marcadores de Espaço: <img src="static/images/markerSpace.png" height="35px" alt="" /><br> Marcadores de evento: <br><img src="static/images/markerEvent.png" height="35px" alt="" /> ',
            },


            {

               intro: '<h2>Feed de atualizações</h2>O feed exibe as últimas atualizações do registros da plataforma <a target="_blank" href="http://mapas.cultura.gov.br">Mapas Culturais</a>.',
                element: ".block"

            },

            {
              intro: '<h2>Indicadores</h2> Os indicadores são informações determinadas pelos os dados coletados da plataforma <a target="_blank" href="http://mapas.cultura.gov.br">Mapas Culturais</a>, você pode ver as opções de indicadores na barra de navegação.',
              element: '.navbar-nav'

            },

            {
              intro: '<h2>Fim !</h2> Agora que você chegou ao final do tour, visite o site e caso queira fazer o tour novamente clique no botão indicado.',
              element: "#tourButton"

            },
        ]
      })

        break;
      default:
      intro.setOptions({
       steps: [

           {
                intro: "<h2>Página de Indicadores.</h2> Na pagina de indicadores você pode ver informaçõe sobre os gráficos e informações coletadas da plataforma Mapas culturais e suas instancias.",
                element:"#titulo"

           },

           {
                intro: "<h2>Descrisção dos indicadores.</h2> Nesta área é possível ver uma pequena explicação sobre o indicador selecionado.",
                element:".subtitle-box"

           },

           {
                intro: "<h2>Dados sobre os indicadores.</h2> Aqui é possível ver alguns dados interessantes sobre o indicador.",
                element:"#indicator-data"

           },

           {
                intro: '<h2>Gráficos.</h2> Nessa área é possível ver os gráficos das informações coletadas da plataforma <a target="_blank" href="http://mapas.cultura.gov.br">Mapas Culturais</a> .',
                element:"#graphics-title"

           }

        ]
      })

    }

    intro.start();

  }

// start intro tour only on first visit to website
var nome = readCookie("nome");
if(nome == null){
    writeCookie("nome", "nome", 30);
    startIntro();
}
