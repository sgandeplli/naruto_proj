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
         sh "terraform init"
        }
    }

        stage ("terraform plan") {
        steps{
          sh "terraform plan"
        }
    }

        stage ("terraform apply") {
        steps{
         sh "terraform apply -auto-approve"
        }
    }
           
  }

}
