provider "google" {
    project = "kubernetes-projects-381902"
    credentials = "${file("credentials.json")}"
    region = "us-central1"
}

resource "google_container_cluster" "onlineboutique_cluster" {
    name        = "onlineboutique-cluster"
    location    = "us-central1"
    node_locations = [ "us-central1-a","us-central1-b","us-central1-c" ]
    initial_node_count = 1
    addons_config {
        http_load_balancing {
            disabled = true
        }
        horizontal_pod_autoscaling {
            disabled = false
        }
    }
    release_channel {
      channel = "REGULAR"
    }
    workload_identity_config {
      workload_pool = "kubernetes-projects-381902.svc.id.goog"
    }
    
    private_cluster_config {
      enable_private_nodes = false
      enable_private_endpoint = false
    }

    cluster_autoscaling {
      auto_provisioning_defaults {
        management {
          auto_repair = true
          auto_upgrade = true
        }
      }
    }
    node_config {
      preemptible = true
      machine_type = "e2-standard-2"
      oauth_scopes = [
        "https://www.googleapis.com/auth/compute",
        "https://www.googleapis.com/auth/devstorage.read_only",
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring.write",
        "https://www.googleapis.com/auth/servicecontrol",
        "https://www.googleapis.com/auth/service.management.readonly",
        "https://www.googleapis.com/auth/trace.append",
      ]
    }

}