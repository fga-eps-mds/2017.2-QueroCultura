
>## O Projeto Quero Cultura
[![Build Status](https://travis-ci.org/fga-gpp-mds/2017.2-QueroCultura.svg?branch=master)](https://travis-ci.org/fga-gpp-mds/2017.2-QueroCultura) 
[![Coverage Status](https://coveralls.io/repos/github/fga-gpp-mds/2017.2-QueroCultura/badge.svg?branch=master)](https://coveralls.io/github/fga-gpp-mds/2017.2-QueroCultura?branch=master)
[![AUR](https://img.shields.io/aur/license/yaourt.svg?colorB=ff69b4)]()

O projeto Quero Cultura surgiu de uma demanda por visualização de dados do Ministério da Cultura por meio do [Mapas Culturais](http://mapas.cultura.gov.br/). O Mapas Culturais é um software livre para mapeamento colaborativo e gestão da cultura.
O Quero Cultura tem como objetivos, a visualização dos dados de eventos, projetos e espaços culturais e o relacionamento dos mesmos por meio de indicadores.

>## Ambiente de Desenvolvimento

O Quero Cultura utiliza o Docker para automatizaço de ambiente. Para contribuir com o projeto siga os passos a seguir:

1. Instale o [docker](https://docs.docker.com/engine/installation/)
2. Instale o [docker compose](https://docs.docker.com/compose/install/)
3. Clone o repositório usando o comando:
  ```
  git clone https://github.com/fga-gpp-mds/2017.2-QueroCultura
  ```
4. Crie e inicie os containers para o serviço:
  ```
  docker-compose up
  ```

>## Desenvolvendo com Docker e Docker Compose
Para os desenvolvedores que não possuem experiência com o desenvolvimento usado o docker e o docker compose, são apresentados alguns comandos abaixo que podem auxiliar aos contribuintes do repositório.
Mas antes, conheçamos os objetos do docker:

>* Imagens: Modelos somente leitura com instruções para criar um container.
>* Containers: Instância executável de uma imagem.
>* Serviços: Permite a escala de vários containers, de forma que trabalhem juntos.

Comandos do Docker:
- `docker ps` : Lista os containers em execução. Com uso da flag `-a`, lista todos os containers.
- `docker images` : Lista imagens.
- `docker rm my-conatainer` : Remove o container `my-container`.
- `docker rmi my-image` : Remove a imagem `my-image`.

Comandos do Docker Compose:
- `docker-compose up` : Constrói as imagens, (re)cria, inicia e anexa containers a um serviço. A flag `-d` executa os cantainers em segundo plano.
- `docker-compose down` : Termina a execução dos containers, os remove e remove networks, volumes e imagens criados por `up`.
- `docker-compose stop` : Termina a execução dos containers sem removê-los.
- `docker-compose start` : Inicia containers existentes para um serviço.
- `docker-compose logs` : Exibe saída de log dos serviços, a flag `-f` segue a saída de log.
- `docker-compose exec web bash` : Executa o comado `bash` no serviço `web`.
