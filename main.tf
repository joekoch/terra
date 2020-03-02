provider "docker" {
  version = "~> 2.6"
  host = "npipe:////.//pipe//docker_engine"
}

# Jenkins Volume
resource "docker_volume" "jenkins_volume" {
  name = "jenkins_data"
}
resource docker_container "jenkins_1" {
  image = "jenkins:terraform"
  name = "myjenkins"
  ports {
    internal = 8080
    external = 8080
  }
  volumes {
    volume_name = "${docker_volume.jenkins_volume.name}"
    container_path = "/var/jenkins_home"
  }

  volumes {
    host_path = "/var/run/docker.sock"
    container_path = "/var/run/docker.sock"
  }
}