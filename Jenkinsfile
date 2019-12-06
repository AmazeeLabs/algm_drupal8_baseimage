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
            git branch: "docker_agent", url: 'https://github.com/AmazeeLabs/algm_drupal8_baseimage.git' //TODO: get this in the right spot.
            container('docker') {
            withEnv(['HOME=/tmp', 'DOCKER_REPO=library', 'GIT_BRANCH=docker_agent', 'DOCKER_HUB=harbor-nginx-lagoon-integrate-harbor.ch.amazee.io/']) {
                stage('Test') {
                    sh """
                    echo $HOME
                    """
                }
                stage('Docker login') {

                     withCredentials([
                       usernamePassword(credentialsId: 'harboruser', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                         sh '''
                           docker login harbor-nginx-lagoon-integrate-harbor.ch.amazee.io --username $DOCKER_USERNAME --password $DOCKER_PASSWORD
                         '''
                       }
                   }
                stage('Docker Build') {
                    sh '''
                    ls -lah
                    cat Makefile
                    make images_build
                    '''
                }
                stage('Docker Push') {
                    sh '''
                    make images_publish
                    '''
                }
                stage('Docker clean images') {
                   sh '''
                   make images_remove
                   '''
                }
              }

            }
        }
    }
}