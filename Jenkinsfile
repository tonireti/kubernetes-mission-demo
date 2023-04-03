pipeline {
  agent any
  
  triggers {
        pollSCM '*/5 * * * *'
    }
  environment {
        PROJECT_ID = 'kubernetes-projects-381902'
        CLUSTER_NAME = 'onlineboutique-cluster'
        LOCATION = 'us-central1'
        CREDENTIALS_ID = 'jenkins-gke-1'
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
        stage('Deploy to GKE') {
            steps{
                step([
                $class: 'KubernetesEngineBuilder',
                projectId: env.PROJECT_ID,
                clusterName: env.CLUSTER_NAME,
                location: env.LOCATION,
                manifestPattern: './release/kubernetes-manifests.yaml',
                credentialsId: env.CREDENTIALS_ID,
                verifyDeployments: true])
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