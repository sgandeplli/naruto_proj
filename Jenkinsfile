pipeline {
  agent any
  environment {
    GOOGLE_CREDENTIAL = credentials("gcp-sa")
  }
  stages{
    stage ("connecting git") {
        steps{
          git branch : "main" , url : "https://github.com/sgandeplli/naruto_proj.git"
        }
    }

      stage ("terraform init") {
        steps{
         sh "teraform init"
        }
    }

        stage ("terraform plan") {
        steps{
          sh "teraform plan"
        }
    }

        stage ("terraform apply") {
        steps{
         sh "teraform apply -auto-approve"
        }
    }
           
  }

}
