#The Mission

Welcome to my interpretation of the mission. The purpose of this is to create a Highly Available GKE cluster using **Terraform** and run a canary deployment using **Jenkins**. The application beinf deployed is the online boutique.

**Online Boutique** is a cloud-first microservices demo application.
Online Boutique consists of an 11-tier microservices application. The application is a
web-based e-commerce app where users can browse items,
add them to the cart, and purchase them.

## Screenshots

| Home Page                                                                                                         | Checkout Screen                                                                                                    |
| ----------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| [![Screenshot of store homepage](./docs/img/online-boutique-frontend-1.png)](./docs/img/online-boutique-frontend-1.png) | [![Screenshot of checkout screen](./docs/img/online-boutique-frontend-2.png)](./docs/img/online-boutique-frontend-2.png) |

## Requirements (GKE)

1. **[Create a Google Cloud Platform project](https://cloud.google.com/resource-manager/docs/creating-managing-projects#creating_a_project)** or use an existing project. Set the `PROJECT_ID` environment variable and ensure the Google Kubernetes Engine and Cloud Operations APIs are enabled.

```
PROJECT_ID="<your-project-id>"
gcloud services enable container.googleapis.com --project ${PROJECT_ID}
```

2. **Terraform.**
If needed, install terraform. Run the command below, this will create the GKE cluster automatically
```
cd terraform
terraform apply
```

3. **Jenkins**
Install Jenkins on gke using the instuctions [here](https://cloud.google.com/kubernetes-engine/docs/archive/jenkins-on-kubernetes-engine-tutorial)

Set up Jenkins [here](https://cloud.google.com/kubernetes-engine/docs/archive/continuous-delivery-jenkins-kubernetes-engine#configure_jenkins_cloud_for_kubernetes)

When running a job in the UI, select **Pipeline** or **Multibranch Pipeline** and use **Pipeline from SCM** and use this git repo as source. 

Run job to deploy application

4. **Istio**
Install istio.

Run the following commands
```
kubectl apply -f ./release/istio-manifests.yaml
kubectl apply -f /canary/destination.yaml
kubectl apply -f /canary/vs-split-traffic.yaml

```
Run this to get the external ip address
```
kubectl get svc

```