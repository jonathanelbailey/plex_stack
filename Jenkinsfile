pipeline {
  agent master
  stages {
    stage('Create VM') {
      steps {
        echo 'test'
        node('cloud.magiccityit.com'){
          winRMClient credentialsId: '95794653-ba47-487b-baa1-1b19cbe04190', hostName: 'cloud.magiccityit.com',
          winRMOperations: [invokeCommand('dir'), sendFile(configurationName: 'DataNoLimits', destination: 'c:\temp\create-vminstance.ps1', source: 'create-vminstance.ps1')]
        }
      }
    }
  }
}