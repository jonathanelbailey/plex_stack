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
        vm_name = 'test'
        vm_size = '1x2'
        os = 'ubuntu-17.10'
      }
      steps {
        powershell(script: '& $env:WORKSPACE\\create-vminstance.ps1 -vm_name $env:vm_name -vm_size $env:vm_size -os $env:os -verbose 4>&; 1exit $lastexitcode', encoding: 'utf-8', returnStatus: true)
        powershell(script: '& $env:WORKSPACE\\create-cloudinit_disc.ps1 4>&1; exit $lastexitcode', returnStatus: true, encoding: 'utf-8')
      }
    }
  }
}