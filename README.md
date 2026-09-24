# terraform-aws-alb-target-group

Terraform module for a load balancer target group, kept separate from
[`terraform-aws-alb`](https://github.com/kn47ytv9mv/terraform-aws-alb)
since one load balancer can have several target groups.

## Cost

A target group carries no charge of its own — cost comes from the
load balancer it is attached to (see `terraform-aws-alb`).

## Usage

```hcl
module "target_group" {
  source = "kn47ytv9mv/alb-target-group/aws"

  vpc_id = aws_vpc.example.id
  port   = 8080
}
```

Or directly from this repository:

```hcl
module "target_group" {
  source = "github.com/kn47ytv9mv/terraform-aws-alb-target-group"

  vpc_id = aws_vpc.example.id
  port   = 8080
}
```

Pair with `terraform-aws-alb` and
[`terraform-aws-alb-listener`](https://github.com/kn47ytv9mv/terraform-aws-alb-listener):

```hcl
module "alb" {
  source = "kn47ytv9mv/alb/aws"

  subnet_ids         = module.public_subnets[*].id
  security_group_ids = [module.alb_security_group.id]
}

module "target_group" {
  source = "kn47ytv9mv/alb-target-group/aws"

  vpc_id = aws_vpc.example.id
  port   = 8080
}

module "listener" {
  source = "kn47ytv9mv/alb-listener/aws"

  load_balancer_arn = module.alb.arn
  port              = 443
  protocol          = "HTTPS"

  ssl_policy       = "ELBSecurityPolicy-2016-08"
  certificate_arn  = module.certificate.validated_arn
  target_group_arn = module.target_group.arn
}
```

## Requirements

| Name | Version |
|---|---|
| terraform | >= 1.0 |
| aws | ~> 6.61 |
| random | ~> 3.9 |

## Providers

| Name | Version |
|---|---|
| aws | ~> 6.61 |
| random | ~> 3.9 |

## Inputs

| Name | Description | Default | Required |
|---|---|---|---|
| name | The name of the target group. If null, a unique name is generated. | `null` | no |
| port | Port the target group forwards traffic to on its targets. | `null` | no |
| protocol | Protocol the target group uses to forward traffic, and that its health check uses. | `"HTTP"` | no |
| vpc_id | The ID of the VPC the target group belongs to. | `null` | no |
| target_type | Type of target the target group routes to (e.g. `'ip'`, `'instance'`, `'lambda'`). | `"ip"` | no |
| health_check_path | Path the target group's health check requests. | `"/"` | no |
| health_check_matcher | HTTP status code(s) the health check treats as healthy. | `"200"` | no |
| health_check_interval | Seconds between health checks. | `30` | no |
| health_check_timeout | Seconds to wait for a health check response before failing it. | `5` | no |
| healthy_threshold | Number of consecutive successful health checks before a target is considered healthy. | `2` | no |
| unhealthy_threshold | Number of consecutive failed health checks before a target is considered unhealthy. | `2` | no |
| stickiness_enabled | Whether to enable `lb_cookie` stickiness on the target group. If null, no stickiness block is set (disabled). | `null` | no |
| stickiness_cookie_duration | Seconds the stickiness cookie is valid for, if `stickiness_enabled` is set. | `86400` | no |
| tags | A map of tags to assign to the target group. | `null` | no |

## Outputs

| Name | Description |
|---|---|
| id | The ID of the target group. |
| arn | The ARN of the target group. |
| name | The name of the target group. |

## License

MIT — see [LICENSE.md](LICENSE.md).
