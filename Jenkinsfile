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
        powershell '& $env:WORKSPACE\\create-vminstance.ps1 -vm_name test -vm_size 1x2 -os ubuntu-17.10 -verbose'
      }
    }
  }
}