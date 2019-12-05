 pipeline {
  agent {
    kubernetes {
      //cloud 'kubernetes'
      yaml """
        apiVersion: v1
        kind: Pod
        spec:
          containers:
          - name: docker
            image: tiangolo/docker-with-compose:latest
            command:
            - sleep
            args:
            - 99d
            env:
              - name: DOCKER_HOST
              value: tcp://docker-host.lagoon.svc.cluster.local:2375
        """
    }
  }
  environment {
   DOCKER_REPO = 'algmprivsecops'
  }
  options {
    buildDiscarder(logRotator(numToKeepStr: '10'))
  }
  stages {
    stage('Test pod') {
      steps {
        container('docker') {
            sh '''
                ls
            '''
        }
      }

    }
    /*
    stage('Docker login') {
      steps {
        withCredentials([
          usernamePassword(credentialsId: 'algmdockerhub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                sh '''
                    docker login --username $DOCKER_USERNAME --password $DOCKER_PASSWORD
                '''
          }
      }
    }
    stage('Docker Build') {
      steps {
        sh '''
        make images_build
        '''
      }
    }
    stage('Verification') {
      steps {
        sh '''
        make images_test
        '''
      }
    }
    stage('Docker Push') {
    steps {
        sh '''
        make images_publish
        '''
      }
    }
    stage('Docker clean images') {
      steps {
        sh '''
        make images_remove
        '''
      }
    }
  */
  }
}
