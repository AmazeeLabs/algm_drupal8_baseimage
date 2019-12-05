podTemplate(label: 'mylabel', cloud: 'openshift', yaml: '''
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
''') {

    node('mylabel') {
        stage('Get Drupal') {
            git url: 'https://github.com/amazeeio/drupal-example.git'
            container('docker') {
            withEnv(['HOME=/tmp', 'DOCKER_REPO=algmprivsecops']) {
                stage('Test') {
                    sh """
                    echo $HOME
                    """
                }
                stage('Docker login') {

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
                 stage('Docker clean images') {
                   steps {
                     sh '''
                     make images_remove
                     '''
                 }
            }
        }
    }
}