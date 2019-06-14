docker build -t vvavepacket/multi-client:latest -t vvavepacket/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vvavepacket/multi-server:latest -t vvavepacket/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vvavepacket/multi-worker:latest -t vvavepacket/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push vvavepacket/multi-client:latest
docker push vvavepacket/multi-server:latest
docker push vvavepacket/multi-worker:latest

docker push vvavepacket/multi-client:$SHA
docker push vvavepacket/multi-server:$SHA
docker push vvavepacket/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vvavepacket/multi-server:$SHA
kubectl set image deployments/client-deployment client=vvavepacket/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vvavepacket/multi-worker:$SHA