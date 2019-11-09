docker build -t rowdy1/multi-client:latest -t rowdy1/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rowdy1/multi-server:latest -t rowdy1/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rowdy1/multi-worker:latest -t rowdy1/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rowdy1/multi-client:latest
docker push rowdy1/multi-server:latest
docker push rowdy1/multi-worker:latest

docker push rowdy1/multi-client:$SHA
docker push rowdy1/multi-server:$SHA
docker push rowdy1/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rowdy1/multi-server:$SHA
kubectl set image deployments/client-deployment client=rowdy1/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rowdy1/multi-worker:$SHA