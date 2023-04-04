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
    

    stage('Deploy Onlineboutique v.1 to GKE') {
      environment {
        DEPLOYMENT_NAME = "onlineboutique-deployment"
      }
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
    stage('Test success Online boutique v.1 deployment'){
      steps{
        withKubeConfig([credentialsId: 'jenkins-gke-1']) {
            sh "kubectl get pods"
          }
        }
      }

    stage('Deploy onlineboutique-demo v.2') {
      environment {
        DEPLOYMENT_NAME = "onlineboutique-deployment"
      }
        steps{
        step([
          $class: 'KubernetesEngineBuilder',
          projectId: env.PROJECT_ID,
          clusterName: env.CLUSTER_NAME,
          location: env.LOCATION,
          manifestPattern: './canary/onlineboutique-v2.yaml',
          credentialsId: env.CREDENTIALS_ID,
          verifyDeployments: true])
        
          }
          
    }
  
      stage('Test onlineboutique-v2 success'){
        steps{
          withKubeConfig([credentialsId: 'jenkins-gke-1']) {
            sh "kubectl get pods"
        }
      }
      }

      
          
          




    
  
  }
}
