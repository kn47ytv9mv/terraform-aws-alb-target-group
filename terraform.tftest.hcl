mock_provider "aws" {}

run "default_config_creates_expected_resources" {
  command = apply

  variables {
    port = 8080
  }

  assert {
    condition     = aws_lb_target_group.resource.protocol == "HTTP"
    error_message = "protocol should default to 'HTTP'."
  }

  assert {
    condition     = aws_lb_target_group.resource.target_type == "ip"
    error_message = "target_type should default to 'ip'."
  }

  assert {
    condition     = length(aws_lb_target_group.resource.health_check[0].path) > 0
    error_message = "The health check block should always be present with its default path."
  }

  assert {
    condition     = length(aws_lb_target_group.resource.name) == 32
    error_message = "When name is left unset, the random_uuid fallback should be truncated to AWS's 32-character limit."
  }
}

run "explicit_name_used_as_is" {
  command = plan

  variables {
    port = 8080
    name = "my-target-group"
  }

  assert {
    condition     = aws_lb_target_group.resource.name == "my-target-group"
    error_message = "A supplied name should be used as-is, not replaced by the random fallback."
  }
}

run "stickiness_disabled_by_default" {
  command = plan

  variables {
    port = 8080
  }

  assert {
    condition     = length(aws_lb_target_group.resource.stickiness) == 0
    error_message = "Leaving stickiness_enabled unset should omit the stickiness block entirely."
  }
}

run "stickiness_enabled_sets_cookie_duration" {
  command = plan

  variables {
    port                       = 8080
    stickiness_enabled         = true
    stickiness_cookie_duration = 3600
  }

  assert {
    condition     = aws_lb_target_group.resource.stickiness[0].enabled == true
    error_message = "stickiness_enabled = true should set the stickiness block's enabled flag."
  }

  assert {
    condition     = aws_lb_target_group.resource.stickiness[0].cookie_duration == 3600
    error_message = "stickiness_cookie_duration should pass through to the stickiness block."
  }
}

run "readme_default_usage" {
  command = plan

  variables {
    vpc_id = "vpc-0123456789abcdef0"
    port   = 8080
  }
}
