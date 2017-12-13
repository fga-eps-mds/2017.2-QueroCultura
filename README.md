
>## O Projeto Quero Cultura
[![Build Status](https://travis-ci.org/fga-gpp-mds/2017.2-QueroCultura.svg?branch=master)](https://travis-ci.org/fga-gpp-mds/2017.2-QueroCultura)
[![Code Health](https://landscape.io/github/fga-gpp-mds/2017.2-QueroCultura/devel/landscape.svg?style=flat)](https://landscape.io/github/fga-gpp-mds/2017.2-QueroCultura/devel)
[![Code Climate](https://codeclimate.com/github/fga-gpp-mds/2017.2-QueroCultura/badges/gpa.svg)](https://codeclimate.com/github/fga-gpp-mds/2017.2-QueroCultura)
[![Coverage Status](https://coveralls.io/repos/github/fga-gpp-mds/2017.2-QueroCultura/badge.svg?branch=HEAD)](https://coveralls.io/github/fga-gpp-mds/2017.2-QueroCultura?branch=HEAD)
[![AUR](https://img.shields.io/aur/license/yaourt.svg?colorB=ff69b4)](https://github.com/fga-gpp-mds/2017.2-QueroCultura/blob/devel/LICENSE)

O projeto Quero Cultura surgiu de uma demanda por visualização de dados do Ministério da Cultura (MinC) por meio do [_Mapas Culturais_](http://mapas.cultura.gov.br/). O _Mapas Culturais_ é um software livre para mapeamento colaborativo e gestão da cultura.
O Quero Cultura tem como objetivos a visualização dos dados de eventos, projetos e espaços culturais e o relacionamento dos mesmos por meio de indicadores.

O repositório é mantido e gerenciado por alunos de Engenharia de Software da Universidade de Brasília no campus Gama (UnB/FGA). A equipe de alunos é reponsável pela ordem do repositório e compromente-se a ajudar e orientar a todos que desejam contribuir. Caso possua interesse, consulte nossas [políticas](https://github.com/fga-gpp-mds/2017.2-QueroCultura/wiki/Pol%C3%ADticas-de-Reposit%C3%B3rio). Dúvidas ou sugestões devem ser encaminhada aos [gestores do projeto](https://github.com/fga-gpp-mds/2017.2-QueroCultura/wiki/Contatos).

>## Ambiente de Desenvolvimento

O Quero Cultura utiliza a plataforma [Docker](https://www.docker.com/what-docker) para isolamento, criação e automação do ambiente de desenvolvimento para evitar problemas de compatibilidade. Os passos abaixo podem ser seguidos para executar a aplicação usando a plataforma:

1. Instale o [docker](https://docs.docker.com/engine/installation/)
2. Instale o [docker compose](https://docs.docker.com/compose/install/)
3. Clone o repositório usando o comando:
  ```
  git clone https://github.com/fga-gpp-mds/2017.2-QueroCultura
  ```
4. Crie e inicie os containers para os serviços:
  ```
  docker-compose up
  ```
5. Acesse a aplicação na porta `80` do seu `localhost`: [http://localhost](http://localhost)
6. Obs: Modifique as chaves e senhas dos bancos de dados ao iniciar o sistema em produção. A chave do Django está localizada em quero_cultura/settings.py, a chave do Metabase está localizada em quero_cultura/views.py e as senhas dos bancos estão localizdas no arquivo docker-compose.yml

>## Mais informações
Informações adicionais podem ser obtidas consultando os links abaixo.
* [Visão Geral do Projeto](https://github.com/fga-gpp-mds/2017.2-QueroCultura/wiki)
* [Termo de Abertura](https://github.com/fga-gpp-mds/2017.2-QueroCultura/wiki/Termo-de-Abertura-do-Projeto)
* [Plano de Gerenciamento do Projeto](https://github.com/fga-gpp-mds/2017.2-QueroCultura/wiki/Plano-de-Gerenciamento-do-Projeto)
  
>## Licença

[GNU General Public License v3.0](https://github.com/fga-gpp-mds/2017.2-QueroCultura/blob/master/LICENSE)
