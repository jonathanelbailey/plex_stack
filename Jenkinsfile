pipeline {
  agent none
  stages {
    stage('Create VM') {
      agent {
        node {
          label 'cloud.magiccityit.com'
        }
        
      }
      environment {
        vm_size = '1x2'
        os = 'ubuntu-17.04'
        vm_name = 'test'
      }
      steps {
        powershell(script: '& $env:WORKSPACE\\create-vminstance.ps1 -vm_name $env:vm_name -vm_size $env:vm_size -os $env:os -verbose 4>&1', encoding: 'utf-8', returnStatus: true)
      }
    }
  }
}