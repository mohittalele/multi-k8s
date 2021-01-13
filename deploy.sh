# this file will Build all the image, apply all k8s configs and imperetively set new images on each deployment
docker build -t mtalele/multi-client:latest -t mtalele/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mtalele/multi-server:latest -t mtalele/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mtalele/multi-worker:latest -t mtalele/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mtalele/multi-client:latest
docker push mtalele/multi-client:$SHA
docker push mtalele/multi-server:latest
docker push mtalele/multi-server:$SHA
docker push mtalele/multi-worker:latest
docker push mtalele/multi-worker:$SHA

kubectl apply -f  ./k8s
kubectl set image Deployment/client-deployment client=mtalele/multi-client:$SHA
kubectl set image Deployment/server-deployment server=mtalele/multi-server:$SHA
kubectl set image Deployment/worker-deployment worker=mtalele/multi-worker:$SHA

