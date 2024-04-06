docker build -t lexigen/multi-client:latest -t lexigen/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lexigen/multi-server:latest -t lexigen/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lexigen/multi-worker:latest -t lexigen/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lexigen/multi-client:latest
docker push lexigen/multi-client:$SHA
docker push lexigen/multi-server:latest
docker push lexigen/multi-server:$SHA
docker push lexigen/multi-worker:latest
docker push lexigen/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=lexigen/multi-client:$SHA
kubectl set image deployments/server-deployment server=lexigen/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=lexigen/multi-worker:$SHA