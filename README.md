# Inception

This project aims to introduce you to system administration by working with Docker. You'll gain hands-on experience with containerization and deploying applications in a multi-container environment.

## Table of Contents
- [Project Overview](#project-overview)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgements](#acknowledgements)

## Project Overview
Inception is designed to help you understand the basics of system administration using Docker. You'll learn to:
- Set up and configure Docker containers.
- Work with Docker Compose to manage multi-container applications.

## Prerequisites
Before you begin, ensure you have the following installed:
- Docker: [Installation Guide](https://docs.docker.com/get-docker/)
- Docker Compose: [Installation Guide](https://docs.docker.com/compose/install/)

## Installation
1. Clone this repository:
    ```sh
    git clone https://github.com/hamidthri/inception.git
    cd inception
    ```

2. Create the necessary directories and build the Docker images:
    ```sh
    make build
    ```

3. Start the Docker containers:
    ```sh
    make up
    ```

## Usage
- Access your application at `http://localhost` (or the appropriate port specified in your Docker setup).
- To stop the containers, run:
    ```sh
    make down
    ```
- To restart the containers, run:
    ```sh
    make restart
    ```
- To stop the containers without removing them, run:
    ```sh
    make stop
    ```
- To start the stopped containers again, run:
    ```sh
    make start
    ```
- To clean up and remove all containers, images, and volumes, run:
    ```sh
    make clean
    ```

## Project Structure
- `Makefile`: Makefile to manage Docker commands.
- `srcs/docker-compose.yml`: Configuration file for Docker Compose.
- `Dockerfile`: Instructions to build individual Docker images.
- `src/`: Source code for your application.

## Contributing
Contributions are welcome! Please fork the repository and create a pull request with your changes. Ensure your code follows the project's coding standards and includes appropriate tests.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgements
- [42 School](https://www.42.us.org/)
- [Docker Documentation](https://docs.docker.com/)

Feel free to reach out if you have any questions or need further assistance. Happy coding!
