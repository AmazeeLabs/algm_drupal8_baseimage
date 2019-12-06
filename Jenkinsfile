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
            git branch: "${params.BRANCH}", url: 'https://github.com/AmazeeLabs/algm_drupal8_baseimage.git'
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
                stage('Docker Build') {
                    sh '''
                    ls -lah
                    cat Makefile
                    make images_build
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