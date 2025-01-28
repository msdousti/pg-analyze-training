docker compose -f docker/docker-compose.yaml up -d

export CHECK="while ! pg_isready &> /dev/null; do echo 'Waiting for docker...'; sleep 1; done"
export CMD="psql -U postgres -ef training.psql"

docker exec -it pg_analyze sh -c "cd /training; $CHECK; $CMD"
