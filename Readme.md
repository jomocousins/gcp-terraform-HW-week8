Runbook

 The goal is to create a configured Managed Instance Group via ClickOps that automatically scales, heals, and distributes instances across multiple zones.
Managed Instance Group ClickOps Runbook
Goal

To create the MIG in the Google Cloud Console, go to Compute Engine → Instance groups → Create instance group, then choose Managed instance group. Select your instance template, choose a regional or multi-zone setup, and set the initial number of instances.

After that, turn on autoscaling and set the minimum and maximum number of VMs. You can base scaling on things like CPU usage or load balancing demand.

Next, enable autohealing by attaching a health check Name the health check, set the scope to regional, then set the protocol to tcp and port 80. Cloud can replace it automatically after the delay you set.

If you are using a regional MIG, Google Cloud will spread instances across the selected zones. You should verify that the instances are balanced across zones after scaling events.

Other important settings include rolling updates, which help update instances without downtime, and attaching the MIG to a backend service or target pool if it will receive traffic from a load balancer. The health check is especially important because an incorrect one can cause healthy instances to be replaced by mistake.




Terraform

What you must include for a VM
When you make a VM in Terraform, you need the basics that tell Google Cloud what to build such as the VM name, machine type, the zone, the boot disk/image, and the network settings. Without those, Terraform does not know what kind of VM to create. How to get the internal and external IPs
After the VM is created, Terraform can show you the IP addresses.

Internal IP is the private address the VM uses inside the network.

External IP is the public address people can use from outside the network.

https://registry.terraform.io/providers/hashicorp/google/3.40.0/docs/resources/compute_instance#network_interface.0.network_ip-3
https://registry.terraform.io/providers/hashicorp/google/3.40.0/docs/resources/compute_instance#argument-reference
https://developer.hashicorp.com/terraform/language/block/output
https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-outputs

Q/A

The difference between the two is the fault tolerance makes sure the system can keep running during downtime or failures and High Availability decreases the downtime through quick recovery and failover mechanisms.
High Availability is best to strive for because of it being more cost-effective and Fault tolerance is more costly due to full redundancy. https://cloud.google.com/blog/products/databases/breaking-down-cloud-sqls-3-fault-tolerance-mechanisms
https://www.couchbase.com/blog/high-availability-vs-fault-tolerance/
Autoscaling automatically adds or removes servers when traffic goes up or down. (like adding servers during lunch rush). Elasticity means your system can stretch or shrink without breaking, no matter the traffic.
Vertical scaling = Make one server bigger (more muscle).
Horizontal scaling = Add more servers (more workers).
Horizontal is usually better since if one server dies, others keep the environment running. Vertical had a single point of failure and its. https://docs.cloud.google.com/architecture/framework/reliability/horizontal-scalability
https://docs.cloud.google.com/architecture/framework/reliability/horizontal-scalability     https://cloud.google.com/discover/what-is-cloud-scalability?hl=en
https://gcpstudyhub.com/blog/horizontal-vs-vertical-scaling-in-google-cloud
Managed instance groups automatically takes care of creating, scaling, and repairing VMs for you. Unmanaged instance groups needs you to add, remove, and fix VMs manually.
https://docs.cloud.google.com/compute/docs/instance-groups/creating-groups-of-unmanaged-instances  https://docs.cloud.google.com/compute/docs/instance-groups
The use cases for health checks used by applications is to replace the failed VMs and instance recreation. The use case for health checks for load balancers is excluding unhealthy VMs from traffic and traffic stoppage to VM. Yes, they can be the same health check resource—you reference one health check object for both MIG and load balancer setups via the same API. 
Can/Should They Match?
Yes, they can be the same—it's one shared Google Cloud resource (like an HTTP or TCP check) you point both the MIG and load balancer to.

Same API: Not separate calls; use compute.healthChecks for both.

Yes, they should match for simple setups—keeps "healthy" meaning the same everywhere and avoids confusion. https://docs.cloud.google.com/load-balancing/docs/health-check-concepts
