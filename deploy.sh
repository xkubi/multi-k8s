docker build -t kubi89/multi-client:latest -t kubi89/multiclient:$SHA -f ./client/Dockerfile ./client
docker build -t kubi89/multi-server:latest -t kubi89/multi0-server:$SHA -f ./server/Dockerfile ./server
docker build -t kubi89/multi-worker:latest -t kubi89/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push kubi89/multi-client:latest
docker push kubi89/multi-server:latest
docker push kubi89/multi-worker:latest
docker push kubi89/multi-client:$SHA
docker push kubi89/multi-server:$SHA
docker push kubi89/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment  server=kubi89/multi-server:$SHA
kubectl set image deployments/client-deployment  client=kubi89/multi-client:$SHA
kubectl set image deployments/worker-deployment  worker=kubi89/multi-worker:$SHA