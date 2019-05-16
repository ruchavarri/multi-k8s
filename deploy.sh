docker build -t ruchavarri/multi-client:latest -t ruchavarri/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ruchavarri/multi-server:latest -t ruchavarri/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ruchavarri/multi-worker:latest -t ruchavarri/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ruchavarri/multi-client:latest
docker push ruchavarri/multi-server:latest
docker push ruchavarri/multi-worker:latest

docker push ruchavarri/multi-client:$SHA
docker push ruchavarri/multi-server:$SHA
docker push ruchavarri/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ruchavarri/multi-server:$SHA
kubectl set image deployments/client-deployment client=ruchavarri/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ruchavarri/multi-worker:$SHA

