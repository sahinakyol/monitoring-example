minikube start

eval $(minikube -p minikube docker-env)

---

docker build -t monitoring-example:latest .

---

kubectl apply -f service.yaml

kubectl apply -f deployment.yaml

minikube service spring-boot-service

---

kubectl apply -f grafana-deployment.yaml

kubectl apply -f grafana-service.yaml

minikube service grafana-service

---

kubectl apply -f prometheus-config.yaml

kubectl apply -f prometheus-deployment.yaml

kubectl apply -f prometheus-service.yaml

minikube service prometheus-service

---

restart xxxx:

kubectl apply -f xxxx.yaml

kubectl delete pod -l app=xxxx

