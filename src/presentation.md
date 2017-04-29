title: Stitch Fix Challenge
output: sf-test.html
controls: true
theme: select/cleaver-select-theme
style: style.css

--

# Stitch Fix Challenge
## Andy Buecker

--

### Requirements:

* Migrate Heroku Rails services to AWS
* Support both public and private services
* Migrate database from Heroku to AWS
* Each service has it's own database and cache
* No down time

--

### Heroku

![Heroku](./diagrams/1_heroku.svg)

**Very** rough assumption of the Heroku setup.

--

### AWS Private Services

![AWS Private](./diagrams/2_aws_priv.svg)

Stand up a private AWS stack along side of Heroku.

VPC Security Groups are used to restricted access to specific location IP's.

Disable allocation of Public IP's on the subnets.

Load balancers distribute the traffic to the Rails service that is managed by
Auto Scaling Groups.

The Rails service has its own auto scaled RDS for postgres and ElasticCache
for Redis.

--

### AWS Public Services

![AWS Public](./diagrams/3_aws_pub.svg)

The public stack is similar to the private stack, but has a publicly accessible
ELB's.

--

### Database Migration

![Migration](./diagrams/4_migration.svg)

The AWS Migration Service continually replicates Heroku Postgres databases to
RDS.

--

### Teardown

![Teardown](./diagrams/5_complete.svg)

When the services on AWS pass integration tests, swap DNS from Heroku to AWS.

Eventually, teardown the Heroku services and AWS Migration Service.

-- p50

### Auto Scale

![Auto Scale](./diagrams/autoScale.svg)

When load on the services increases or decreases, AWS automatically manages
the scaling of the nodes to stay within a minimum and maximum node count.

* Auto Scaling Groups for the Rails service instances.
* RDS for the Postgres
* ElasticCache for Redis

-- p75

### Deployment

![CD](./diagrams/cd.svg)


As part of the continuos delivery process for each service, Packer builds an
AMI of the service.

CloudFormation then updates the stack with the new AMI of the service.

-- w128

# That's it.  Simple.

![](./diagrams/gipsy_raf.128.jpg)
