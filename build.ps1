& minikube -p minikube docker-env --shell powershell | Invoke-Expression
$module = $args[0]
.\gradlew.bat ${module}:jibDockerBuild
minikube image ls | Select-String docker.io/library/ | % { $_.Line }
