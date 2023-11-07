docker build -t andinianst93/complex-client:latest -t andinianst93/complex-client:$SHA -f ./client/Dockerfile ./client
docker build -t andinianst93/complex-server t andinianst93/complex-server:$SHA -f ./server/Dockerfile ./server
docker build -t andinianst93/complex-worker -f t andinianst93/complex-worker:$SHA ./worker/Dockerfile ./worker

docker push andinianst93/complex-client:latest
docker push andinianst93/complex-server:latest
docker push andinianst93/complex-worker:latest

docker push andinianst93/complex-client:$SHA
docker push andinianst93/complex-server:$SHA
docker push andinianst93/complex-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=andinianst93/complex-server:$SHA
kubectl set image deployments/client-deployment server=andinianst93/complex-client:$SHA
kubectl set image deployments/worker-deployment server=andinianst93/complex-worker:$SHA