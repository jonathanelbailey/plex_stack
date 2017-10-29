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
        os = 'ubuntu-17.10'
      }
      steps {
        powershell(script: '& $env:WORKSPACE\\create-vminstance.ps1 -vm_name $env:vm_name -vm_size $env:vm_size -os $env:os -verbose 4>&1', encoding: 'utf-8', returnStatus: true)
      }
    }
    stage('Build Metadata ISO') {
      steps {
        powershell(script: '& $env:WORKSPACE\\create-cloudinit_disc.ps1 4>&1', encoding: 'utf-8', returnStatus: true)
      }
    }
    stage('Start VM') {
      steps {
        powershell(script: 'start-vm $env:vm_name', returnStatus: true, returnStdout: true)
      }
    }
  }
  environment {
    vm_name = 'test'
  }
}