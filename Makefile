up:
	sudo docker-compose up -d web
	sudo docker-compose up -d postgres
	sleep 30
	sudo docker-compose exec postgres psql metabase quero_cultura -f /postgres_metabase/metabase.sql
	sudo docker-compose up -d metabase
	sudo docker-compose up -d nginx

down:
	sudo docker-compose down --volume

test-js:
	sudo docker-compose -f docker-compose.testjs.yml up

test-py:
	sudo docker-compose up -d web
	sudo docker-compose exec web py.test

logs:
	sudo docker-compose logs -f
