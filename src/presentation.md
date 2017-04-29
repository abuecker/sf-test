title: Stitch Fix Project
output: index.html
controls: true
theme: select/cleaver-select-theme
style: style.css

--

# Stitch Fix Project
## Andy Buecker

--

### Requirements:

* Migrate Heroku Rails services to AWS
* Support both public and private services
* Migrate database from Heroku to AWS
* Each service has its own database and cache
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

Load balancers distribute the traffic to the Rails services that are managed by
Auto Scaling Groups.

The Rails services have their own auto scaled RDS for postgres and ElasticCache
for Redis.

--

### AWS Public Services

![AWS Public](./diagrams/3_aws_pub.svg)

The public stack is similar to the private stack, but has publicly accessible
ELB's.

--

### Database Migration

![Migration](./diagrams/4_migration.svg)

The AWS Migration Service continually replicates the Heroku Postgres databases
to RDS.

--

### Teardown

![Teardown](./diagrams/5_complete.svg)

When the services on AWS pass integration tests, swap the DNS from Heroku to
AWS.

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

CloudFormation then updates the stack with the new AMI.

-- w128

# That's it.  Simple.
## https://github.com/abuecker/sf-test

![](./diagrams/gipsy_raf.128.jpg)
