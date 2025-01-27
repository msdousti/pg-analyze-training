docker compose -f docker/docker-compose.yaml up -d

export PGPASSWORD=postgres_analyze_training

while ! psql -h localhost -p 54320 -ef training.psql 2> /dev/null
do
	echo 'Waiting for docker...'
	sleep 1
done;
