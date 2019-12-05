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
                stage('Test') {
                    sh """
                    docker-compose help
                    echo ${BUILD_NUMBER}
                    make -v
                    """
                }
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
            }
        }

    }
}