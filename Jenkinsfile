pipeline {
  agent none
  stages {
    stage('Create VM') {
      agent {
        node {
          label 'cloud.magiccityit.com'
        }
        
      }
      steps {
        echo 'test'
        powershell(returnStdout: true, returnStatus: true, script: 'dir', encoding: 'utf-8')
      }
    }
  }
}