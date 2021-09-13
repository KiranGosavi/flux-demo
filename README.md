## Automation Challenge ##

Step 1: Custom build the docker image  
Docker command to build the custom nginx webserver image:

```
 docker build -t imageName:tag .

```

Step 2: Locally test your image and then push to dockerhub . Your static page should be accessible at http://localhost:5001/

```
 docker-compose up -d --build

 docker-compose ps

     Name         Command   State          Ports        
--------------------------------------------------------
nginx-webserver   nginx     Up      0.0.0.0:5000->80/tcp

 docker-compose down

```
Step 3: Create kubernetes deployment with above cluster image

```
 kubectl apply -f nginx-webserver-deployment.yaml

 kubectl apply -f nginx-service.yaml 

```

Step 4: create TLS certificate and secret
```
 openssl req -x509 -newkey rsa:4096 -sha256 -nodes -keyout tls.key -out tls.crt -subj "/CN=automation-challenge.cgi.com" -days 365

 kubectl create secret tls automation-challenge-cgi-com-tls --cert=tls.crt --key=tls.key

```

Step 5: Add ingress service 
```
 kubectl apply -f ingress.yaml

```
## Test deployment ##

Test the challenge using below command:

```
 curl --cacert tls.crt https://automation-challenge.cgi.com

Output:
<!doctype html>
<html>
  <head>
    <title>Hello nginx</title>
    <meta charset="utf-8" />
  </head>
  <body>
    <h1>
        Hello CGI! 
    </h1>
  </body>
</html>
```
### TODO ###
Step 5: CI/CD pipeline (optional)

