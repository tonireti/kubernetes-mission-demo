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
      withKubeConfig([credentialsId: 'jenkins-gke-1']){
        sh "kubectl config use-context onlineboutique-cluster"
        sh "kubectl apply -f ./release/kubernetes-manifests.yaml"
      }
    
    }

    stage('Deliver') {
      environment {
        DEPLOYMENT_NAME = "example-deployment"
      }
      withKubeConfig([credentialsId: 'jenkins-gke-1']){
            sh "kubectl get pods"
            sh "kubectl get service frontend-external | awk '{print \$4}'"
      }
    }
  }
}