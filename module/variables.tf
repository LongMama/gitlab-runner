variable "instance_type" {
  description = "Instance type"
  default     = "t2.micro"
}

variable "url" {
  description = "Gitlab-ci coordinator URL"
  type        = string
  default     = "https://gitlab.com/"
}

variable "token" {
  description = "The token to register the runner"
  type        = string
  default     = ""
}

variable "tags" {
  description = "The tags associated with the runner, separated by commas"
  type        = string
  default     = ""
}

variable "user" {
  description = "SSH user for connection to gitlab-runner"
  type        = string
  default     = ""
}
