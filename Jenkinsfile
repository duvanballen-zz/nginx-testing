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
                    sh "${env.docker} build -t ${env.image} ."
                }
            }
            stage ("reemplazar imagen de docker")
            {
                steps {
                    sh "DOCKERIMAGE=${env.image} envsubst < nginx.tpl.yaml > /tmp/nginx.yaml"
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