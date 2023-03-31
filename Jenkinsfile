pipeline {
  agent any
  
  triggers {
        pollSCM '*/5 * * * *'
    }
  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
    

    stage('Deploy to GKE') {
      environment {
        DEPLOYMENT_NAME = "onlineboutique-deployment"
      }
      steps {
        withKubeConfig([credentialsId: 'jenkins-gke-1']) {
            sh 'curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.20.5/bin/linux/amd64/kubectl"'  
            sh 'chmod u+x ./kubectl'
            sh "./kubectl config get-contexts"
            sh "./kubectl config view"
            sh "./kubectl get svc"
            sh "./kubectl cluster-info"
            //sh "./kubectl config use-context gke_kubernetes-projects-381902_us-central1_onlineboutique-cluster"
            //sh "./kubectl apply -f ./release/kubernetes-manifests.yaml"
        }
      }
    
    }

    stage('Deliver') {
      environment {
        DEPLOYMENT_NAME = "onlineboutique-deployment"
      }
      steps {
        withKubeConfig([credentialsId: 'jenkins-gke-1']) {
            sh "./kubectl get pods"
            sh "./kubectl get service frontend-external | awk '{print \$4}'"
        }
      }
    }
  }
}