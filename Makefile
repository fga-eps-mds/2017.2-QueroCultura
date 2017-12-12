up:
	docker-compose up -d web
	docker-compose up -d postgres
	sleep 30
	docker-compose exec postgres psql metabase quero_cultura -f /postgres_metabase/metabase.sql
	docker-compose up -d metabase
	docker-compose up -d nginx

down: 
	docker-compose down --volume

test-js:
	docker-compose -f docker-compose.testjs.yml up

test-py:
	docker-compose up -d web
	docker-compose exec web py.test

logs:
	docker-compose logs -f