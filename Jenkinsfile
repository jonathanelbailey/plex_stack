pipeline {
  agent any
  stages {
    stage('Create VM') {
      steps {
        winRMClient{
          hostName('cloud.magiccityit.com')
          credentialsId('95794653-ba47-487b-baa1-1b19cbe04190')
          sendFile('create-vminstance.ps1' 'c:\temp\create-vminstance.ps1' 'DataNoLimits')
          invokeCommand('dir')
        }
      }
    }
  }
}