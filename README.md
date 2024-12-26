# PHP Apache Docker Setup for Arm64/8

This README provides instructions on how to build and run a Docker container using the provided Dockerfile for M1 and above. The Dockerfile sets up an Apache web server with PHP 8.2, including several common extensions and configurations.

## Prerequisites
-  Mac with ARM processor
- Docker installed on your system
- Basic knowledge of Docker commands

## Building the Docker Image

1. Save the Dockerfile in your project's root directory.

2. Open a terminal and navigate to the directory containing the Dockerfile.

3. Build the Docker image using the following command:

   ```
   docker build -t php-apache-app .
   ```

   This command builds a Docker image and tags it as `php-apache-app`. The `.` at the end specifies that the Dockerfile is in the current directory.

## Note
- `php-apache-app`: this tag naming can also be changed in the commad above to any relatable name of your liking ie: the command can also look like this ` docker build -t php-apache-php-8 .` or anything else of your choosing.

## Running the Docker Container

After successfully building the image, you can run a container using the following command:

```
docker run -d -p 8080:80 --name my-php-app php-apache-app
```

This command does the following:
- `-d`: Runs the container in detached mode (in the background)
- `-p 8080:80`: Maps port 8080 on your host to port 80 in the container
- `--name my-php-app`: Names the container "my-php-app"
- `php-apache-app`: Specifies the image to use

Your application should now be accessible at `http://localhost:8080`.

## Customization

- The Dockerfile is set up to copy all files from the current directory into `/app/` in the container. Ensure all your PHP files are in the same directory as the Dockerfile before building.
- The document root is set to `/app/`, so your `index.php` should be directly in this directory.

## Features

This Dockerfile includes:
- PHP 8.2 with Apache
- MySQL, PDO, and ZIP extensions
- Redis extension
- Apache mod_rewrite enabled
- Support for .htaccess files
- Error reporting configured for production use (errors logged but not displayed)

## Stopping the Container

To stop the running container:

```
docker stop my-php-app
```

## Removing the Container

If you want to remove the container:

```
docker rm my-php-app
```

## Rebuilding

If you make changes to your PHP files or the Dockerfile, you'll need to rebuild the image and run a new container:

1. Remove the old container (if it's running):
   ```
   docker stop my-php-app
   docker rm my-php-app
   ```

2. Rebuild the image:
   ```
   docker build -t php-apache-app .
   ```

3. Run a new container:
   ```
   docker run -d -p 8080:80 --name my-php-app php-apache-app
   ```

## Troubleshooting

- If you encounter permission issues, ensure that your PHP files have the correct permissions.
- To view logs: `docker logs my-php-app`
- To access the container's shell: `docker exec -it my-php-app /bin/bash`

For more detailed information about Docker commands and usage, refer to the [official Docker documentation](https://docs.docker.com/).
