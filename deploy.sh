docker build -t alextagger/multi-client:latest -t alextagger/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alextagger/multi-server:latest -t alextagger/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alextagger/multi-worker:latest -t alextagger/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alextagger/multi-client:latest
docker push alextagger/multi-server:latest
docker push alextagger/multi-worker:latest

docker push alextagger/multi-client:$SHA
docker push alextagger/multi-server:$SHA
docker push alextagger/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alextagger/multi-server:$SHA
kubectl set image deployments/client-deployment client=alextagger/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alextagger/multi-worker:$SHA