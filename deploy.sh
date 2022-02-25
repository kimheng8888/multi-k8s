docker build -t kimheng8888/multi-client:latest -t kimheng8888/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kimheng8888/multi-server:latest -t kimheng8888/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kimheng8888/multi-worker:latest -t kimheng8888/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push kimheng8888/multi-client:latest
docker push kimheng8888/multi-server:latest
docker push kimheng8888/multi-worker:latest
docker push kimheng8888/multi-client:$SHA
docker push kimheng8888/multi-server:$SHA
docker push kimheng8888/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kimheng8888/multi-server:$SHA
kubectl set image deployments/client-deployment client=kimheng8888/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kimheng8888/multi-worker:$SHA