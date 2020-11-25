docker build -t khaberk/multi-client:latest -t khaberk/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t khaberk/multi-server:latest -t khaberk/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t khaberk/multi-worker:latest -t khaberk/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push khaberk/multi-client:latest
docker push khaberk/multi-server:latest
docker push khaberk/multi-worker:latest

docker push khaberk/multi-client:$SHA
docker push khaberk/multi-server:$SHA
docker push khaberk/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=khaberk/multi-server:$SHA
kubectl set image deployments/client-deployment client=khaberk/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=khaberk/multi-worker:$SHA