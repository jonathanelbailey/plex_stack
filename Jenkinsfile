pipeline {
  agent {
    node {
      label 'cloud.magiccityit.com'
    }
    
  }
  stages {
    stage('Create VM') {
      steps {
        echo 'test'
        powershell(returnStdout: true, returnStatus: true, script: 'test.ps1', encoding: 'utf-8')
      }
    }
  }
}