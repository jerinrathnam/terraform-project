header: ""
footer: ""
inputs:
  - name: aws_region
    type: string
    description: null
    default: us-east-1
    required: false
  - name: enable_dns_hostnames
    type: bool
    description: null
    default: true
    required: false
  - name: instance_count
    type: map(number)
    description: null
    default: null
    required: true
  - name: instance_type
    type: map(string)
    description: null
    default: null
    required: true
  - name: map_public_ip_on_launch
    type: bool
    description: null
    default: true
    required: false
  - name: name
    type: string
    description: null
    default: null
    required: true
  - name: naming_prefix
    type: string
    description: null
    default: jerin
    required: false
  - name: project
    type: string
    description: null
    default: null
    required: true
  - name: vpc_cidr_block
    type: map(string)
    description: null
    default: null
    required: true
  - name: vpc_subnet_count
    type: map(number)
    description: null
    default: null
    required: true
  - name: web_name
    type: string
    description: null
    default: null
    required: true
modules:
  - name: vpc
    source: terraform-aws-modules/vpc/aws
    version: 3.14.1
    description: null
  - name: web_app_s3
    source: ./modules/web-app-s3
    version: ""
    description: null
outputs:
  - name: loadbalancer_dns
    description: null
providers:
  - name: aws
    alias: null
    version: ~> 3.0
  - name: random
    alias: null
    version: ~> 3.0
requirements:
  - name: aws
    version: ~> 3.0
  - name: random
    version: ~> 3.0
resources:
  - type: instance
    name: nginx
    provider: aws
    source: hashicorp/aws
    mode: managed
    version: latest
    description: null
  - type: lb
    name: nginx
    provider: aws
    source: hashicorp/aws
    mode: managed
    version: latest
    description: null
  - type: lb_listener
    name: nginx
    provider: aws
    source: hashicorp/aws
    mode: managed
    version: latest
    description: null
  - type: lb_target_group
    name: nginx
    provider: aws
    source: hashicorp/aws
    mode: managed
    version: latest
    description: null
  - type: lb_target_group_attachment
    name: nginx
    provider: aws
    source: hashicorp/aws
    mode: managed
    version: latest
    description: null
  - type: s3_bucket_object
    name: object
    provider: aws
    source: hashicorp/aws
    mode: managed
    version: latest
    description: null
  - type: security_group
    name: alb_sg
    provider: aws
    source: hashicorp/aws
    mode: managed
    version: latest
    description: null
  - type: security_group
    name: nginx_sg
    provider: aws
    source: hashicorp/aws
    mode: managed
    version: latest
    description: null
  - type: integer
    name: rand
    provider: random
    source: hashicorp/random
    mode: managed
    version: latest
    description: null
  - type: availability_zones
    name: available
    provider: aws
    source: hashicorp/aws
    mode: data
    version: latest
    description: null
  - type: elb_service_account
    name: root
    provider: aws
    source: hashicorp/aws
    mode: data
    version: latest
    description: null
