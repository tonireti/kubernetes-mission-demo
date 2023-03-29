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
            sh "kubectl config use-context onlineboutique-cluster"
            sh "kubectl apply -f ./release/kubernetes-manifests.yaml"
        }
      }
    
    }

    stage('Deliver') {
      environment {
        DEPLOYMENT_NAME = "example-deployment"
      }
      steps {
        withKubeConfig([credentialsId: 'jenkins-gke-1']) {
            sh "kubectl get pods"
            sh "kubectl get service frontend-external | awk '{print \$4}'"
        }
      }
    }
  }
}