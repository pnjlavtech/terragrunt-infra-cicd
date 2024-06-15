// specified in the github actions workflow
// tflint {
//   required_version = ">= 0.50"
// }

plugin "terraform" {
  enabled = true
  preset  = "recommended"
}


plugin "aws" {
    enabled = true
    version = "0.32.0"
    source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

config {
    call_module_type = "local"
}