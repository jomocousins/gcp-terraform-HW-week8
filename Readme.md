Runbook

Managed Instance Group (MIG) ClickOps Runbook
Goal
Create a fully configured Managed Instance Group (MIG) via the GCP Console (ClickOps) that automatically scales, heals, and distributes instances across multiple zones.

Prerequisites
GCP project with billing enabled.
Appropriate IAM roles: Compute Admin or equivalent.
Predefined Instance Template (OS, machine type, startup script, disks, network, etc.).
Network and subnetwork configured for the desired zones.
Familiarity with the GCP Console UI.
Steps
1. Create the Managed Instance Group
Navigate to Compute Engine → Instance groups → Create instance group.
Select Managed instance group.
Choose your Instance Template.
Select Multiple zones and pick the zones or region for your group.
Set the Target size (initial number of instances).
2. Enable Autoscaling
Scroll to Autoscaling and enable it.
Set the min/max number of instances.
Choose a scaling metric, e.g., CPU utilization or load balancing capacity.
Confirm and save.
3. Enable Autohealing
Scroll to Autohealing in the MIG creation page.
Specify a health check (must exist beforehand).
Set a initial delay (time before health checks start on new instances).
4. Verify Multi-Zone Distribution
Check that the instance distribution shows instances across all selected zones.
The “Regional” MIG option automatically balances instances across zones.
Verify that scaling events maintain distribution by observing instances in each zone after a scale-up/scale-down.
5. Critical Additional Configurations
Rolling updates: configure if instances will be updated without downtime.
Target pools or backend services: attach the MIG to a load balancer for traffic routing.
Health check: must be reliable; otherwise, autohealing may incorrectly replace instances.
Instance Template updates: MIGs use templates; updates require a rolling update strategy.






Terraform

What you must include for a VM
When you make a VM in Terraform, you need the basics that tell Google Cloud what to build such as the VM name, machine type, the zone, the boot disk/image, and the network settings. Without those, Terraform does not know what kind of VM to create. How to get the internal and external IPs
After the VM is created, Terraform can show you the IP addresses.

Internal IP is the private address the VM uses inside the network.

External IP is the public address people can use from outside the network.


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
