podTemplate(label: 'tmp-builder',
            containers: [containerTemplate(name: 'go-build', image: 'golang:1.7.5-alpine', command: 'cat', ttyEnabled: true),
                         containerTemplate(name: 'docker', image: 'docker', command: 'cat', ttyEnabled: true),
                         containerTemplate(name: 'helm', image: 'lachlanevenson/k8s-helm:v2.3.1', command: 'cat', ttyEnabled: true),],
            volumes: [hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock'),
                      secretVolume(secretName: 'docker-user-pass', mountPath: '/etc/secrets/docker')]) {
  node('tmp-builder') {
    def project = 'prepor'
    def appName = 'tmp-app'
    def tag = "${env.BRANCH_NAME}.${env.BUILD_NUMBER}"
    def image = "${project}/${appName}:${tag}"

    def dockerApi = "1.23"

    checkout scm

    stage('Build') {
      container('go-build') {
        sh("go build -o tmp-app")
      }
    }

    stage('Build image') {
      container('docker') {
        def user = readFile("/etc/secrets/docker/username.txt")
        def password = readFile("/etc/secrets/docker/password.txt")
        sh("DOCKER_API_VERSION=${dockerApi} docker login -u ${user} -p ${password}")
        sh("DOCKER_API_VERSION=${dockerApi} docker build -t ${image} .")
        sh("DOCKER_API_VERSION=${dockerApi} docker push ${image}")
      }
    }

    stage("Deploy Application"){
      container('helm') {
        sh("helm upgrade -i --set image.tag=${tag} --set image.tag=app-${env.BRANCH_NAME}.team.navimize.com tmp-app-${env.BRANCH_NAME} chart/tmp-app")
      }
    }
  }
}
