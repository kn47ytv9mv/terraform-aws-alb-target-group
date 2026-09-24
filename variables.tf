variable "name" {
  default     = null
  description = "The name of the target group. If null, a unique name is generated."
}

variable "port" {
  default     = null
  description = "Port the target group forwards traffic to on its targets."
}

variable "protocol" {
  default     = "HTTP"
  description = "Protocol the target group uses to forward traffic, and that its health check uses."
}

variable "vpc_id" {
  default     = null
  description = "The ID of the VPC the target group belongs to."
}

variable "target_type" {
  default     = "ip"
  description = "Type of target the target group routes to (e.g. 'ip', 'instance', 'lambda')."
}

variable "health_check_path" {
  default     = "/"
  description = "Path the target group's health check requests."
}

variable "health_check_matcher" {
  default     = "200"
  description = "HTTP status code(s) the health check treats as healthy."
}

variable "health_check_interval" {
  default     = 30
  description = "Seconds between health checks."
}

variable "health_check_timeout" {
  default     = 5
  description = "Seconds to wait for a health check response before failing it."
}

variable "healthy_threshold" {
  default     = 2
  description = "Number of consecutive successful health checks before a target is considered healthy."
}

variable "unhealthy_threshold" {
  default     = 2
  description = "Number of consecutive failed health checks before a target is considered unhealthy."
}

variable "stickiness_enabled" {
  default     = null
  description = "Whether to enable lb_cookie stickiness on the target group. If null, no stickiness block is set (disabled)."
}

variable "stickiness_cookie_duration" {
  default     = 86400
  description = "Seconds the stickiness cookie is valid for, if stickiness_enabled is set."
}

variable "tags" {
  default     = null
  description = "A map of tags to assign to the target group."
}
