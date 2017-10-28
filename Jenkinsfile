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
        powershell '$env:WORKSPACE\\test.ps1'
      }
    }
  }
}