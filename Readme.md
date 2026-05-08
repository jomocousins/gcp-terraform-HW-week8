


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
