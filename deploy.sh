docker build -t systtek/multi-client:latest -t systtek/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t systtek/multi-server:latest -t systtek/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t systtek/multi-worker:latest -t systtek/multi-worler:$SHA -f ./worker/Dockerfile ./worker
docker push systtek/multi-client:latest
docker push systtek/multi-server:latest
docker push systtek/multi-worker:latest

docker push systtek/multi-client:$SHA
docker push systtek/multi-server:$SHA
docker push systtek/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=systtek/multi-server:$SHA
kubectl set image deployments/client-deployment client=systtek/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=systtek/multi-worker:$SHA
