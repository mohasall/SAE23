docker build -t image-portf .
docker run -p 82:80 -it -d --name some-portf image-portf