podTemplate(label: 'tmp-builder',
            containers: [containerTemplate(name: 'go-build', image: 'golang:1.6.3', command: 'cat', ttyEnabled: true),
                         containerTemplate(name: 'docker', image: 'docker', command: 'cat', ttyEnabled: true)],
            volumes: [hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock'),
                      secretVolume(secretName: 'docker-user-pass', mountPath: '/etc/secrets/docker')]) {
  node('tmp-builder') {
    def project = 'prepor'
    def appName = 'tmp-app'
    def imageTag = "${project}/${appName}:${env.BRANCH_NAME}.${env.BUILD_NUMBER}"

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
        sh("DOCKER_API_VERSION=${dockerApi} docker build -t ${imageTag} .")
        sh("DOCKER_API_VERSION=${dockerApi} docker push ${imageTag}")
      }
    }

    stage 'Push image to registry'

    stage "Deploy Application"
    sh("echo hi!")
    // Create namespace if it doesn't exist
    // sh("kubectl get ns ${env.BRANCH_NAME} || kubectl create ns ${env.BRANCH_NAME}")
    // // Don't use public load balancing for development branches
    // sh("sed -i.bak 's#LoadBalancer#ClusterIP#' ./k8s/services/frontend.yaml")
    // sh("sed -i.bak 's#gcr.io/cloud-solutions-images/gceme:1.0.0#${imageTag}#' ./k8s/dev/*.yaml")
    // sh("kubectl --namespace=${env.BRANCH_NAME} apply -f k8s/services/")
    // sh("kubectl --namespace=${env.BRANCH_NAME} apply -f k8s/dev/")
    // echo 'To access your environment run `kubectl proxy`'
    // echo "Then access your service via http://localhost:8001/api/v1/proxy/namespaces/${env.BRANCH_NAME}/services/${feSvcName}:80/"

  }
}
