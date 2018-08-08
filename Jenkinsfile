#!/usr/bin/env groovy

pipeline {

        agent {label "kubectl"}

        environment {
        docker      = "docker -H tcp://127.0.0.1:2375"
        kube        = "/usr/bin/kubectl"
        image       = "duvanballen/nginx-hola"
        commfile    = "/tmp/commit-file"
        }

        stages {
            
            stage ("compilar imagen de docker")
            {
                steps {
                    script {
                    sh "git rev-parse HEAD > ${env.commitfile}"
                    def COMM = ((String)(readFile("${env.commitfile}"))).toString().trim()
                    sh "${env.docker} build -t ${env.image}:${COMM} ."
                    }
                }
            }
            stage ("subir imagen")
            {
                steps {
                    script {
                    def COMM = ((String)(readFile("${env.commitfile}"))).toString().trim()
                    sh "${env.docker} push ${env.image}:${COMM}"
                    }
                }
            }
            stage ("reemplazar imagen de docker")
            {
                steps {
                    script {
                        def COMM = ((String)(readFile("${env.commitfile}"))).toString().trim()
                        sh "DOCKERIMAGE=${env.image}:${COMM} envsubst < nginx.tpl.yaml > /tmp/nginx.yaml"
                    }
                }
            }
            stage ("desplegar contenedor")
            {
                steps {
                    sh "${kube} apply -f /tmp/nginx.yaml"
                }
            }
        }
}