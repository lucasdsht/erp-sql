# Define default action when you just call `make`
all: up

# Start the Docker environment
up:
	docker-compose up -d

# Stop the Docker environment
down:
	docker-compose down

# Stop and remove volumes (including data volume)
clean:
	docker-compose down -v

# View logs
logs:
	docker-compose logs

# Follow log output
logs-watch:
	docker-compose logs -f

# Rebuild the Docker images and start
rebuild:
	docker-compose up -d --build

# Execute MySQL command line
mysql-cli:
	docker-compose exec mysql mysql -u root -p

# Access the phpMyAdmin container shell (less common need)
phpmyadmin-shell:
	docker-compose exec phpmyadmin sh

